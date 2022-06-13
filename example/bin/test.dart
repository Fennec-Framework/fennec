import 'package:fennec/fennec.dart';
import 'package:fennec/src/annotations/annotations.dart';

@RestController(path: '/example')
class Test {
  @Route('/test', RequestMethod.get())
  Future test(Request request, Response response) async {
    response.send('hello world');
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
    if (1 == 2) {
      return MiddleWareResponse(MiddleWareResponseEnum.next);
    }
    response.badRequest().send('not allowed second');
    return MiddleWareResponse(MiddleWareResponseEnum.stop);
  }

  @Middleware(priority: 1)
  Future<MiddleWareResponse> test1(Request request, Response response) async {
    if (1 == 2) {
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
      Iterable<Object> authorities)
      : super(id, username, email, password, authorities);

  @override
  UserDetails fromJson(Map<String, dynamic> map) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  bool isAccountNonExpired() {
    // TODO: implement isAccountNonExpired
    throw UnimplementedError();
  }

  @override
  bool isAccountNonLocked() {
    // TODO: implement isAccountNonLocked
    throw UnimplementedError();
  }

  @override
  bool isCredentialsNonExpired() {
    // TODO: implement isCredentialsNonExpired
    throw UnimplementedError();
  }

  @override
  bool isEnabled() {
    // TODO: implement isEnabled
    throw UnimplementedError();
  }
}
