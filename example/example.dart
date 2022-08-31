import 'dart:io';
import 'package:fennec/fennec.dart';
import 'package:path/path.dart' as path;

void main(List<String> arguments) async {
  Application application = Application();
  application.setPort(3114).setHost(InternetAddress.loopbackIPv4);
  application
      .setCorsOptions(CorsOptions(methods: "PUT,GET,DELETE", origin: '*'));
  application.setCors((req, res) {
    var x = CorsOptions(methods: "PUT,GET,DELETE", origin: '*');
    res.headers.add('a', x.headers);
    res.headers.add('Access-Control-Allow-Origin', x.origin);
    res.headers.add('Access-Control-Allow-Methods', x.methods);
    res.headers.add('Access-Control-Allow-Headers', x.headers);
    res.headers.add('Access-Control-Expose-Headers', x.headers);
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
      requestMethod: RequestMethod.delete(),
      requestHandler: (Request req, Response res) {
        res.ok().json({'aaÄ': 'show received'});
      },
      middlewares: [
        (req, res) {
          if (1 == 2) {
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
