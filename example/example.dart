import 'dart:async';
import 'dart:isolate';

import 'package:fennec/fennec.dart';
import 'package:path/path.dart' as path;

void main(List<String> arguments) async {
  Application application = Application();

  application.setNumberOfIsolates(6);
  application.useWebSocket(true);
  application.setPort(8000);
  application.addRouters([testRouter()]);
  application.addActor(CustomisedActor("customizedActor"));
  application.setViewPath(path.current + '/example');

  ServerInfo serverInfo = await application.runServer();
  print("Server is running at Port ${serverInfo.port}");
}

Router testRouter() {
  Future<Middleware> testMiddleware(
      ServerContext serverContext, Request req, Response res) async {
    if (2 == 2) {
      return Next();
    }
    return Stop(res.forbidden(body: {"error": "not allowed"}).json());
  }

  Router router = Router();
  router.useMiddleware(testMiddleware);
  router.useMiddleware((serverContext, req, res) {
    if (2 == 2) {
      return Next();
    }
    return Stop(res.forbidden(body: {"error": "not allowed"}).json());
  });
  router.get(
      path: "/test/{id}",
      requestHandler: (context, req, res) async {
        context.actorContainers['customizedActor']!.execute("insert");
        CustomisedActor customisedActor =
            await context.actorContainers['customizedActor']!.getInstance();
        print(customisedActor.get("get"));
        return res.ok(body: {"id": req.pathParams['id']}).json();
      });

  router.routerInitState(routerInitState: (ServerContext context) async {});

  router.get(
      path: "/test_template/{id}",
      requestHandler: (context, req, res) async {
        print(req.pathParams['id']);
        return res.renderHtmlAsString(
            "<!DOCTYPE html <html> <body><h1>Heading 1</h1><h2>Heading 2</h2><h3>Heading 3</h3><h4>Heading 4</h4><h5>Heading 5</h5><h6>Heading 6</h6></body></html>");
      });
  router.get(
      path: "/file",
      requestHandler: (context, req, res) {
        return res.ok(body: req.files.first.filename);
      });
  router.ws(
      path: "/connect",
      websocketHandler: (context, websocket) {
        /// handle new connected websocket client.
      });
  router.get(
      path: "/template",
      requestHandler: (context, req, res) {
        return res.render("file");
      });

  return router;
}

class CustomisedActor extends Actor {
  final List<String> _strings = [];

  CustomisedActor(String name) : super(name);

  @override
  FutureOr<void> execute(String action,
      {Map<String, dynamic> data = const {}}) {
    if (action == 'insert') {
      _strings.add(" new item");
    } else {
      if (_strings.isNotEmpty) {
        _strings.removeLast();
      }
    }
  }

  @override
  FutureOr get(String action, {Map<String, dynamic> data = const {}}) {
    if (action == "get") {
      return _strings;
    }
    return null;
  }
}
