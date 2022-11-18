/// Fennec is a dart web framework with the principal goal make web server side more easy and fast to develop.
library fennec;

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';

part 'src/application.dart';

part 'src/body_parser.dart';

part 'src/exceptions/route_notfound_exception.dart';

part 'src/exceptions/view_exception.dart';

part 'src/interfaces/callback_interfaces.dart';

part 'src/template/html/engine.dart';

part 'src/file_info.dart';

part 'src/utils/utils.dart';

part 'src/template/html/file_repository.dart';

part 'src/template/html/html_engine.dart';

part 'src/middleware/middlware_response.dart';

part 'src/middleware/cors.dart';

part 'src/middleware/cors_options.dart';

part 'src/template/html/view.dart';

part 'src/template/html/template_render.dart';

part 'src/server/server_input.dart';

part 'src/server/server_context.dart';

part 'src/server/server.dart';

part 'src/websocket/upgraded_websocket.dart';

part 'src/request.dart';

part 'src/response.dart';

part 'src/route/route.dart';

part 'src/isolate/isolate_action.dart';

part 'src/isolate/isolate_task_handler.dart';

part 'src/isolate/isolate_context.dart';

part 'src/isolate/isolate_event.dart';

part 'src/isolate/isolate_supervisor.dart';

part 'src/isolate/isolate_spawn_message.dart';

part 'src/isolate/isolate_error.dart';

part 'src/isolate/isolate_server_info.dart';

part 'src/isolate/isolate_handler.dart';

part 'src/route/router.dart';

part 'src/route/route_handler.dart';

part 'src/server/server_task_handler.dart';

part 'src/server/actor/actor.dart';

part 'src/server/actor/actor_container.dart';

part 'src/server/actor/actor_containers.dart';

part 'src/server/actor/actor_action.dart';

part 'src/server/actor/actor_task_handler.dart';

part 'src/server/actor/actors.dart';

part 'src/server/actor/actor_event.dart';

part 'src/request_method.dart';

part 'src/server/server_info.dart';

part 'src/security/user_details.dart';

part 'src/security/user_repository.dart';

part 'src/security/authentication_provider.dart';

part 'src/exceptions/user_notfound_exception.dart';
