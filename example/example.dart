import 'dart:io';
import 'package:fennec/fennec.dart';

void main(List<String> arguments) async {
  ApplicationConfiguration applicationCofiguration = ApplicationConfiguration();
  applicationCofiguration.setPort(8000).setHost(InternetAddress.loopbackIPv4);
  TestRouter testRouter = TestRouter();
  testRouter.get(
      path: '/simple', requestHandler: TestController().test, middlewares: []);
  testRouter.get(
      path: '/simple1',
      requestHandler: (Request req, Response res) {
        res.send(req.body);
      },
      middlewares: []);
  applicationCofiguration.addRouter(testRouter);
  applicationCofiguration.addRoute(Route(
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

  Application application = Application(applicationCofiguration);
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

class TestRouter extends Router {
  @override
  String getRoutePath() {
    return '/Test';
  }
}

class TestController {
  void test(Request request, Response response) {
    response.ok().send('hellow world');
  }

  Future<MiddleWareResponse> testMiddleware(Request req, Response res) async {
    res.html("You are not allowed to do that");
    return MiddleWareResponse(MiddleWareResponseEnum.stop);
  }
}
