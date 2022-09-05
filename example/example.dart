import 'dart:io';
import 'package:fennec/fennec.dart';
import 'package:path/path.dart' as path;

void main(List<String> arguments) async {
  String html =
      '<script> function bar() { var myList = []; for (i = 0; i < aa.test1.length; i++) { var li = document.createElement("li");var text = document.createTextNode(i);li.appendChild(text);document.getElementById("myUl").appendChild(li);}}window.onload = event => {console.log(event);bar();};</script><h1>aa</h1> <button onclick="bar()">click</button><ul id="myUl"></ul>';
  Application application = Application();
  application.setPort(3114).setHost(InternetAddress.loopbackIPv4);
  application
      .setCorsOptions(CorsOptions(methods: "PUT,GET,DELETE", origin: '*'));
  application.useMiddleware((req, res) {
    CorsOptions x = CorsOptions(methods: "PUT,GET,DELETE", origin: '*');
    res.headers.set('Access-Control-Allow-Origin', x.origin);
    res.headers.set('Access-Control-Allow-Methods', x.methods);
    res.headers.set('Access-Control-Allow-Headers', x.headers);
    res.headers.set('Access-Control-Expose-Headers', x.headers);
    if (req.httpRequest.method == 'OPTIONS') {
      return Stop(res);
    }
    return Next();
  });
  application.setViewPath(path.current);
  application.get(
    path: '/dynamic_routes/@userId',
    requestHandler: (req, res) {
      return res.ok(body: {'A': 12}, contentType: ContentType.json);
    },
  );

  Router testRouter = Router(routerPath: '/Test');
  testRouter.useMiddleware((req, res) {
    if (1 == 2) {
      return Stop(res.forbidden());
    }

    return Next();
  });

  testRouter.get(path: '/simple', requestHandler: TestController().test);

  testRouter.get(
      path: '/simple1',
      requestHandler: (Request req, Response res) {
        return res.redirect('/Test/simple');
      },
      middlewares: []);
  application.addRouter(testRouter);

  application.addRoute(Route(
      path: '/show',
      requestMethod: RequestMethod.get(),
      requestHandler: (Request req, Response res) {
        if (1 == 2) {
          return res.redirect('/Test/simple1');
        } else {
          return res.ok(body: {'a': 1}, contentType: ContentType.json);
        }
      },
      middlewares: [
        (req, res) {
          if (1 == 2) {
            return Next();
          }
          return Stop(res.forbidden(
              body: {"error": "not allowed"}, contentType: ContentType.json));
        }
      ]));

  Server server = Server(application);
  WebSocketHandler webSocketHandler = WebSocketHandler();
  webSocketHandler.registerWebSocketHandler(server);
  webSocketHandler.clientsListener.stream.listen((event) {
    print('new client');
    if (event.headers!.value('token') != null) {
      webSocketHandler.addClient(event);
      webSocketHandler.sendToAllJson({'key': 'value'});
    } else {
      event.webSocket.add('not allowed');
    }
  });
  //send data to all registred clients
  webSocketHandler.sendToAllJson({'key': 'value'});
  await server.startServer();
}

class TestController {
  Response test(Request request, Response response) {
    return response.render('test.html', parameters: {'Title': 'redirect'});
  }

  Future<AMiddleWareResponse> testMiddleware(Request req, Response res) async {
    return Next();
  }
}
