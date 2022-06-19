
<p align="center">
<img src="https://user-images.githubusercontent.com/55693316/173706793-0666f8a8-67d6-4d1b-8b79-78fa4808e72e.png" height="500" />
</p>


# Fennec is a dart web framework with the principal goal: make web server side more easy and fast to develop.


# Packages

| Packages                    | pub                                           |
| :---                        |    :----:                                     |         
| fennec (core framework)      | [fennec](https://pub.dev/packages/fennec)    |
| fennec_jwt                  | [fennec_jwt](https://pub.dev/packages/fennec_jwt)| 

# installation:

1) create a simple dart project. you can use terminal for that **dart create 'projectname'**
2) install the framework from [pub.dev](https://pub.dev/packages/fennec)

# make your first request:


create your First RestController:

``` dart
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

```

**Fennec Framework** has three types of Routing:

- **Route** is simple Route without any post executions or middlewares before the request will be executed.
- **AuthenticatedRoute** is a Route that required also a milldware class where the deveveloper can define all Operations and Middlwares (for example  authenticate the token) that must be executed before the request will be executed.
- **AuthorizatedRoute** is a Route that required also a milldware and class for Authorizate the user and a List of Roles of user that can use this request.
  this Route will typically used for softwares with many roles of users.
  
  
  
## Middleware 

it must be a subtype of the class **MiddlewareHandler** , here an example how to implement it:

``` dart
class MiddlewareHanlderImpl extends MiddlewareHandler<MiddlewareHanlderImpl> {
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

```

every Middlware inside the class must be annotated with @Middleware() and have this signature  Future<MiddleWareResponse> 'methodname'(Request request, Response response). the middlware can also without async implemented. priority is for determining which Middlware should be firtly executed.
higher Priority will be first executed.
  
  

## UserProvider
  
UserProvider is an interface that contains the function loadUser based and the request data and Roles used on the **AuthorizatedRoute**
  
Example of implementation of **UserProvider**
  
``` dart
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
  
```
  
``` dart
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
```
  
  
## WebSocket
 
WebSocket is already integrated in the core of Framework.
  
how to use it :
  
``` dart
  
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
  
```
  

  
  
## Start your Server and test your first Request

  
``` dart
import 'package:fennec/fennec.dart';
import 'package:path/path.dart' as path;

import 'test.dart';

void main(List<String> arguments) async {
  Application application = Application('0.0.0.0', 8080);
  application.set('cache', true);
  application.set('views', path.join(path.current, '/views'));
  application.addController(Test);
  Server server = Server(application);
  await server.startServer();
}
```
  
  

# deploy
  
  - **heroku cloud:** [here](https://github.com/Fennec-Framework/heroku-buildpack)  is heroku-buildpack for dart and inside it  an example how to deploy Fennec Framework on heroku cloud for free.
    to test an example you can try this two endpoints:
    - https://fennec-deploy.herokuapp.com/healthcheck/servercheck
     
    - https://fennec-deploy.herokuapp.com/healthcheck
  
  - for next days, another example for aws and goolge run will be uploaded.
  
  
# License

[MIT](https://github.com/Fennec-Framework/fennec/blob/master/LICENSE)



