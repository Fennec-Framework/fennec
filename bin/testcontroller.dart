import 'package:fennec/fennec.dart';

import 'package:path/path.dart' as path;

Future<void> main() async {
  print('Welcome to Fennec');
  Application application = Application('0.0.0.0', 8080);
  print(path.join(path.current, '/views'));
  application.set('views', path.join(path.current, '/views'));
  application.setRootPath(path.url.current + '/lib');
  Server server = Server(application);
  await server.startServer();
}
