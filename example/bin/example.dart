import 'dart:isolate';
import 'dart:mirrors';

import 'package:fennec/fennec.dart';
import 'package:path/path.dart' as path;
//import 'package:fennec/src/annotations/annotations.dart';

import 'test.dart';

void main(List<String> arguments) async {
  print('Hello world!');

  print('Welcome to Fennec');
  Application application = Application('0.0.0.0', 8080);
  print(path.join(path.current, '../example/views'));
  application.setRootPath(
      '/Users/akramchorfi/Desktop/Fennec Framework/Packages/fennec/example/views');

  application.set('views',
      '/Users/akramchorfi/Desktop/Fennec Framework/Packages/fennec/example/views');

  //application.addController(Test);
  Server server = Server(application);
  await server.startServer();
}
