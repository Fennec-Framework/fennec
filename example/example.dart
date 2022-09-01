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
  application.use((req, res) {
    CorsOptions x = CorsOptions(methods: "PUT,GET,DELETE", origin: '*');
    res.headers.set('Access-Control-Allow-Origin', x.origin);
    res.headers.set('Access-Control-Allow-Methods', x.methods);
    res.headers.set('Access-Control-Allow-Headers', x.headers);
    res.headers.set('Access-Control-Expose-Headers', x.headers);
    if (req.httpRequest.method == 'OPTIONS') {
      res.close();
      return null;
    }
    return Next();
  });
  application.setViewPath(path.current);
  application.get(
    path: '/dynamic_routes/@userId',
    requestHandler: (req, res) {
      res.render('s');
      res.json({'userId': req.pathParams['userId']});
    },
  );

  Router testRouter = Router(routerPath: '/Test');
  testRouter.useMiddleware((req, res) {
    if (1 == 1) {
      return null;
    }
    res.forbidden().send('sddd');
    return Next();
  });

  testRouter.get(path: '/simple', requestHandler: TestController().test);
  testRouter.get(
      path: '/simple1',
      requestHandler: (Request req, Response res) {
        res.redirect(Uri.parse('http://localhost:8000/Test/simple?akram=12'));
      },
      middlewares: []);
  application.addRouter(testRouter);

  application.addRoute(Route(
      path: '/show',
      requestMethod: RequestMethod.get(),
      requestHandler: (Request req, Response res) {
        res.render('not_found.html', parameters: {
          "sasd": 123,
          'tester': ["aa11", "sdwsd", 11]
        });
      },
      middlewares: [
        (req, res) {
          if (2 == 2) {
            return Next();
          }
          res.forbidden().json({'ss': 'not allowed'});
          return null;
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
  void test(Request request, Response response) {
    response.ok().json(request.params);
  }

  Future<Next?> testMiddleware(Request req, Response res) async {
    res.html("You are not allowed to do that");
    return Next();
  }
}
