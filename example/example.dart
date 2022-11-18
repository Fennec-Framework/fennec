import 'dart:isolate';

import 'package:fennec/fennec.dart';

void main(List<String> arguments) async {
  Application application = Application();

  application.setNumberOfIsolates(1);
  application.setPort(8000);
  application.addRouters([testRouter()]);

  ServerInfo serverInfo = await application.runServer();
  print("Server is running at Port ${serverInfo.port}");
}

Router testRouter() {
  Router router = Router();
  router.routerInitState(routerInitState: (ServerContext context) async {});

  router.get(
      path: "/test_template/@id",
      requestHandler: (context, req, res) async {
        return res.renderHtmlAsString(
            "<!DOCTYPE html <html> <body><h1>Heading 1</h1><h2>Heading 2</h2><h3>Heading 3</h3><h4>Heading 4</h4><h5>Heading 5</h5><h6>Heading 6</h6></body></html>");
      });

  return router;
}
