/// Fennec is a dart web framework with the principal goal make web server side more easy and fast to develop.
library fennec;

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:mirrors';

import 'package:fennec/src/annotations/controller_instance.dart';
import 'package:fennec/src/annotations/middlware_annotation_entity.dart';
import 'package:fennec/src/annotations/restcontroller_routes_mapping.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';

part 'src/annotations/annotations.dart';

part 'src/application.dart';
part 'src/body_parser.dart';
part 'src/exceptions/route_notfound_exception.dart';
part 'src/exceptions/view_exception.dart';
part 'src/interfaces/callback_interfaces.dart';
part 'src/template/html/engine.dart';
part 'src/file_info.dart';
part 'src/template/html/file_repository.dart';
part 'src/template/html/html_engine.dart';
part 'src/middlware_response.dart';
part 'src/template/html/view.dart';
part 'src/server.dart';
part 'src/websocket/websocket_handler.dart';
part 'src/websocket/upgraded_websocket.dart';
part 'src/request.dart';
part 'src/response.dart';
part 'src/route/route.dart';
part 'src/route/route_handler.dart';
part 'src/request_method.dart';
part 'src/server_info.dart';
part 'src/security/user_details.dart';
part 'src/security/user_repository.dart';
part 'src/security/authentication_provider.dart';
part 'src/exceptions/user_notfound_exception.dart';
