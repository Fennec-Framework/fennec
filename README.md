<p align="center">
<img src="https://user-images.githubusercontent.com/55693316/173706793-0666f8a8-67d6-4d1b-8b79-78fa4808e72e.png" height="500" />
</p>

# Fennec is a dart web framework with the principal goal: make web server side more easy and fast to develop.

# Packages

| Packages                |                        pub                        |
| :---------------------- | :-----------------------------------------------: |
| fennec (core framework) |     [fennec](https://pub.dev/packages/fennec)     |
| fennec_pg               |  [fennec_pg](https://pub.dev/packages/fennec_pg)  |
| fennec_jwt              | [fennec_jwt](https://pub.dev/packages/fennec_jwt) |

# installation:

1. create a simple dart project. you can use terminal for that **dart create 'projectname'**
2. install the framework from [pub.dev](https://pub.dev/packages/fennec)

# make your first request:

create your First Router:

```dart
class TestRouter extends Router {
  @override
  String getRoutePath() {
    return '/Test';
  }
}

```

create your First Controller:

```dart
class TestController {
  void test(Request request, Response response) {
    response.ok().send('hellow world');
  }
}
```

call your Router and Controller

```dart
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
      middlewares: []));


```

## Middleware

it must be a typedef **MiddlewareHandler** and must return always **MiddleWareResponse**. here an example how to implement it:

```dart
 Future<MiddleWareResponse> testMiddleware(Request req, Response res) async {
    res.html("You are not allowed to do that");
    return MiddleWareResponse(MiddleWareResponseEnum.stop);
  }


```

## dynamic routes

here is an example hot to use dynamic routes

```dart

Future dynamicRoutes(Request request, Response response) async {
    response.json({
      'userId': request.pathParams!['user_id'],
      'docId': request.pathParams!['doc_id']
    });
  }

```

## File System Routing

an example how to handle files

```dart


Future fileSystems(Request request, Response response) async {
    response.json({
      'file1': request.files.first.toString(),
    });
}

```

## WebSocket

WebSocket is already integrated in the core of Framework.

how to use it :

```dart

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

## Multithreading

Fennec Framework supports also Multithreading over isolates. To increate the number of used isolates just call the function setNumberOfIsolates. the default number of isolates is 1

**example**

```dart

applicationCofiguration.setNumberOfIsolates(1);

```

## Start your Server and test your first Request

```dart
import 'package:fennec/fennec.dart';
import 'package:path/path.dart' as path;

import 'test.dart';

void main(List<String> arguments) async {
ApplicationConfiguration applicationCofiguration = ApplicationConfiguration();
  applicationCofiguration
      .addControllers([Test])
      .setPort(8000)
      .setHost(InternetAddress.loopbackIPv4);

  Application application = Application(applicationCofiguration);
  Server server = Server(application);
  await server.startServer();
}
```

# deploy

- **heroku cloud:** [here](https://github.com/Fennec-Framework/heroku-buildpack) is heroku-buildpack for dart and inside it an example how to deploy Fennec Framework on heroku cloud for free.
  to test an example you can try this two endpoints:

  - https://fennec-deploy.herokuapp.com/healthcheck/servercheck

  - https://fennec-deploy.herokuapp.com/healthcheck

- for next days, another example for aws and goolge run will be uploaded.

# Benchmarks using [wrk](https://github.com/wg/wrk)

after running this endpoint using Fennec Framework on local machine (MacBook Pro (13-inch, 2019, Two Thunderbolt 3 ports), we could gets this data:

- t: number of threads
- c: number of open connections
- d: duration of test

```dart
 @Route('/test', RequestMethod.get())
  Future test(Request request, Response response) async {
    response.send('hello world');
  }

```

**wrk -t1 -c100 -d60s http://localhost:8000/example/test**

- Running 1m test @ http://localhost:8000/example/test
- 1 threads and 100 connections
- Thread Stats Avg Stdev Max +/- Stdev
- Latency 6.63ms 1.83ms 86.51ms 96.81%
- Req/Sec 15.30k 1.38k 16.52k 91.17%
- 913472 requests in 1.00m, 177.72MB read
- Requests/sec: 15209.67
- Transfer/sec: 2.96MB

**wrk -t10 -c100 -d60s http://localhost:8000/example/test**

- Running 1m test @ http://localhost:8000/example/test
- 10 threads and 100 connections
- Thread Stats Avg Stdev Max +/- Stdev
- Latency 6.50ms 1.27ms 104.08ms 96.71%
- Req/Sec 1.55k 124.24 2.41k 87.15%
- 926903 requests in 1.00m, 180.33MB read
- Requests/sec: 15435.91
- Transfer/sec: 3.00MB

## import information

Fennec Framework after with version >= 1.0.0 doesn't support more annotations because the big discussions about the library mirrors. as alernatives you can use Route or Route as showed in this example.

> > > > > > > dev

# License

[MIT](https://github.com/Fennec-Framework/fennec/blob/master/LICENSE)
