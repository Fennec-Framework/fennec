import 'package:fennec/fennec.dart';
import 'package:path/path.dart' as path;

import 'test.dart';

void main(List<String> arguments) async {
  Application application = Application('0.0.0.0', 8080);
  application.set('cache', true);
  application.set('views', path.join(path.current, '/views'));
  application.addController(Test);
  Server server = Server(application);
  WebSocketHandler webSocketHandler = WebSocketHandler();
  webSocketHandler.registerWebSocketHandler(server);
  webSocketHandler.clientsListener.stream.listen((event) {
    if (event.headers!.value('token') != null) {
      webSocketHandler.addClient(event);
    } else {
      event.webSocket.addError('not allowed');
    }
  });
  //Send data to all registred Clients
  webSocketHandler.sendToAllJson({'key': 'value'});
  await server.startServer();
}
