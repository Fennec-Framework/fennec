<p align="center">
<img src="https://user-images.githubusercontent.com/55693316/173706793-0666f8a8-67d6-4d1b-8b79-78fa4808e72e.png" height="500" />
</p>

# Fennec is a multi-threaded, robust Dart Server-Side Framework.

# Packages

| Packages                |                                     pub                                     |
| :---------------------- | :-------------------------------------------------------------------------: |
| fennec (core framework) |                  [fennec](https://pub.dev/packages/fennec)                  |
| fennec_pg               |               [fennec_pg](https://pub.dev/packages/fennec_pg)               |
| fennec_jwt              |              [fennec_jwt](https://pub.dev/packages/fennec_jwt)              |
| fennec_socket_io_server | [fennec_socket_io_server](https://pub.dev/packages/fennec_socket_io_server) |

# installation:

1. create a simple dart project. you can use terminal for that **dart create 'projectname'**
2. install the framework from [pub.dev](https://pub.dev/packages/fennec)

# supported features by fennec:

1. Multi-threaded http request.
2. Sharing Data between Isolates if using multiples Isolates.
3. WebSocket request.
4. Handling requests with a simple and solid Router logic.
5. Handling dynamic path routes.
6. Middlewares at level of every request and Router level.
7. Templates rendering system with html extension.
8. Handling Form Data.

# make your first request:

you can make a request by creating a [Route] and add it to [Application] instance or create
a [Router] and add it to [application] instance.

# create a Router.

```dart
Router testRouter() {
  Router router = Router();

  router.get(
      path: "/test",
      requestHandler: (context, req, res) async {
        return res.ok(body: "hello world");
      });

  return router;
}


```

## Middleware

it must be a typedef **MiddlewareHandler** and must return always **MiddleWare**. here an example
how to implement it:

```dart
  Future<Middleware> testMiddleware(ServerContext serverContext, Request req, Response res) async {
  if (1 == 2) {
    return Next();
  }
  return Stop(res.forbidden(body: {"error": "not allowed"}).json());
}


```

## Add Middleware to a Router

you can use also define a Router Middleware by.

```dart

router.useMiddleware((
serverContext, req, res) {
if (1 == 2) {
return Next();
}
return Stop(res.forbidden(body: {"error": "not allowed"}).json());
});


```

## Sharing Data between Isolates if using multiples Isolates.

Isolate is an isolated environment, inside which there is memory allocated to it and its EventLoop. but sometimes you want to share Data between Isolates or have the same Data content on all Isolates.

Fennec let you do that by using Actor Concept.

first you need to create your Actor customized class that is a subclass of Actor.

example how to implement it.
```dart

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


```

after implementing of your needed subclasses of [Actor], you need just to add it/them to your [Application] by using addActor or addActors in [Application] instance.

with [ServerContext] instance you can have access to your Actor/Actors by their name and you can call get and execute methods to return some Data from Actor or execute some operations.


## dynamic routes

here is an example how to use dynamic path routes

```dart
router.get(path: "
/test/{id}
"
,
requestHandler: (
context, req, res) {
return res.ok(body: {"id": req.pathParams['id']}).json();
});

```

## File System Routing

an example how to handle files

```dart
router.get(path: "
/getFile
"
,
requestHandler: (
context, req, res) {
return res.ok(body: req.files.first.filename);
});

```

## Template with html extension

you can render also html templates with fennec Framework. you need to determine the path for your
html files. application.setViewPath(path.current + '/example');

an example how to use it.

```dart

router.get(path: "
/template
"
,
requestHandler: (
context, req, res) {
return res.render("file");
});

```

## WebSocket

WebSocket is already integrated in the core of Framework. firstly to use Websocket . you need to
make the useWebSocket object at [Application] instance true.

how to use it :

```dart
  router.ws(path: "
/connect
"
,
websocketHandler: (
context, websocket) {
/// handle new connected websocket client.
});


```

## Multithreading

Fennec Framework supports also Multithreading over isolates. To increase the number of used isolates
just call the function setNumberOfIsolates. the default number of isolates is 1

**example**

```dart

application.setNumberOfIsolates(1
);

```

## Start your Server and test your first Request

```dart
import 'package:fennec/fennec.dart';


void main(List<String> arguments) async {
  Application application = Application();

  application.setNumberOfIsolates(1);
  application.useWebSocket(true);
  application.setPort(8000);
  application.addRouters([testRouter()]);

  ServerInfo serverInfo = await application.runServer();
  print("Server is running at Port ${serverInfo.port}");
}}
```

# deploy

- **heroku cloud:** [here](https://github.com/Fennec-Framework/heroku-buildpack) is heroku-buildpack
  for dart and inside it an example how to deploy Fennec Framework on heroku cloud for free. to test
  an example you can try this two endpoints:

    - https://fennec-deploy.herokuapp.com/healthcheck/servercheck

    - https://fennec-deploy.herokuapp.com/healthcheck

- for next days, another example for aws and goolge run will be uploaded.

# Benchmarks using [wrk](https://github.com/wg/wrk)

after running this endpoint using Fennec Framework on local machine (MacBook Pro (13-inch, 2019, Two
Thunderbolt 3 ports), we could gets this data:

- t: number of threads
- c: number of open connections
- d: duration of test

```dart
  router.get(path: "
/test
"
,
requestHandler: (
context, req, res) async {
return res.ok(body: "hello world");
});

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

Fennec Framework after with version >= 1.0.0 doesn't support more annotations because the big
discussions about the library mirrors. as alernatives you can use Route or Route as showed in this
example.

# License

[MIT](https://github.com/Fennec-Framework/fennec/blob/master/LICENSE)
