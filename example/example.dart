import 'dart:io';
import 'package:fennec/fennec.dart';
import 'package:path/path.dart' as path;

void main(List<String> arguments) async {
  Application application = Application();
  application.setPort(8000).setHost(InternetAddress.loopbackIPv4);
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
      return MiddleWareResponse(MiddleWareResponseEnum.next);
    }
    res.forbidden().send('sddd');
    return MiddleWareResponse(MiddleWareResponseEnum.stop);
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
        res.ok().send('show received');
      },
      middlewares: [
        (req, res) {
          if (1 == 2) {
            return MiddleWareResponse(MiddleWareResponseEnum.next);
          }
          res.forbidden().send('not allowed');
          return MiddleWareResponse(MiddleWareResponseEnum.stop);
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

  Future<MiddleWareResponse> testMiddleware(Request req, Response res) async {
    res.html("You are not allowed to do that");
    return MiddleWareResponse(MiddleWareResponseEnum.stop);
  }
}
