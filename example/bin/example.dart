import 'dart:io';

import 'package:fennec/fennec.dart';

import 'test.dart';

void main(List<String> arguments) async {
  ApplicationConfiguration applicationCofiguration = ApplicationConfiguration();
  applicationCofiguration
      .addControllers([Test])
      .setPort(8000)
      .setHost(InternetAddress.loopbackIPv4);

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
  //Send data to all registred Clients
  webSocketHandler.sendToAllJson({'key': 'value'});
  await server.startServer();
}
