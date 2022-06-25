import 'dart:io' show WebSocket;

import 'package:fennec/fennec.dart';

@RestController(path: '/example')
class Test {
  @Route('/test', RequestMethod.get())
  Future test(Request request, Response response) async {
    response.send('hello world');
  }

  @Route('/dynamic_route/@user_id/@doc_id', RequestMethod.get())
  Future dynamicRoutes(Request request, Response response) async {
    print(request.pathParams!);
    response.json({
      'userId': request.pathParams!['user_id'],
      'docId': request.pathParams!['doc_id']
    });
  }

  @Route('/files', RequestMethod.get())
  Future fileSystems(Request request, Response response) async {
    Stopwatch stopwatch = Stopwatch()..start();

    for (int i = 0; i < 1000000; i++) {
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
