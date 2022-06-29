import 'dart:io';
import 'package:fennec/fennec.dart';

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
  //send data to all registred clients
  webSocketHandler.sendToAllJson({'key': 'value'});
  await server.startServer();
}

@RestController(path: '/example')
class Test {
  @Route('/test', RequestMethod.get())
  Future test(Request request, Response response) async {
    response.send('hello world');
  }

  @Route('/dynamic_route/@user_id/@doc_id', RequestMethod.get())
  Future dynamicRoutes(Request request, Response response) async {
    response.json({
      'userId': request.pathParams!['user_id'],
      'docId': request.pathParams!['doc_id']
    });
  }

  @Route('/files', RequestMethod.get())
  Future fileSystems(Request request, Response response) async {
    for (int i = 0; i < 1000; i++) {
      print(i);
    }
    response.json({
      'file1': '123',
    });
  }

  @AuthenticatedRoute('/template', RequestMethod.get(), MiddlewareHanlderImpl())
  Future testMiddleWare(Request request, Response response) async {
    response.render('template.html');
  }

  @AuthorizatedRoute('/authorization', RequestMethod.get(),
      MiddlewareHanlderImpl(), ['ADMIN'], UserProviderImpl())
  Future testAuthorization(Request request, Response response) async {
    response.render('template.html');
  }
}

class MiddlewareHanlderImpl extends MiddlwareHandler<MiddlewareHanlderImpl> {
  const MiddlewareHanlderImpl();
  @Middleware(priority: 0)
  Future<MiddleWareResponse> test(Request request, Response response) async {
    if (1 == 1) {
      return MiddleWareResponse(MiddleWareResponseEnum.next);
    }
    response.badRequest().send('not allowed second');
    return MiddleWareResponse(MiddleWareResponseEnum.stop);
  }

  @Middleware(priority: 1)
  Future<MiddleWareResponse> test1(Request request, Response response) async {
    if (1 == 1) {
      return MiddleWareResponse(MiddleWareResponseEnum.next);
    }
    response.badRequest().send('not allowed first ');
    return MiddleWareResponse(MiddleWareResponseEnum.stop);
  }
}

class UserProviderImpl extends UserProvider {
  const UserProviderImpl();
  @override
  @AuthorizationRequired()
  Future<UserDetails?> loadUser(
      Request request, Response response, List<String> roules) async {
    if (!roules.contains('element')) {
      response.forbidden().send('not allowed');
      return null;
    }
    return UserDetailsImpl(1, 'tester', '1@web.de', '123456', []);
  }
}

class UserDetailsImpl extends UserDetails {
  UserDetailsImpl(id, String username, String email, String password,
      Iterable<String> authorities)
      : super(id, username, email, password, authorities);

  @override
  UserDetails fromJson(Map<String, dynamic> map) {
    return UserDetailsImpl(map['id'], map['username'], map['email'],
        map['password'], map['authorities']);
  }

  @override
  bool isAccountNonExpired() {
    return true;
  }

  @override
  bool isAccountNonLocked() {
    return true;
  }

  @override
  bool isCredentialsNonExpired() {
    return true;
  }

  @override
  bool isEnabled() {
    return true;
  }
}
