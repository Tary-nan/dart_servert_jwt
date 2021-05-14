import 'package:boilerplate_server_side_dart/src/auth/middleware/check_autorization.dart';
import 'package:boilerplate_server_side_dart/src/auth/middleware/cors.dart';
import 'package:boilerplate_server_side_dart/src/realtime/realtime.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

// ignore: avoid_relative_lib_imports
import '../lib/src/auth/auth_api.dart';
// ignore: avoid_relative_lib_imports
import '../config/config.dart';
// ignore: avoid_relative_lib_imports
import '../lib/src/user_api/user_api.dart';

const _hostname = 'localhost';
var port = 8090;

void main(List<String> args) async {
  var databasse = Db(Env.mongoUrl);
  await databasse.open();

  print('connect to databasse');

  var app = Router();
  final store = databasse.collection('users');
  final secret = Env.mongoUrl; 

  // Authenticate user
  app.mount('/auth/', AuthApi(secret: secret, store: store).router);

  //Api for User
  app.mount('/users/', UserApi(store: store).router);

  // Realtime
  app.mount('/realtime/', Realtime(store: store).router);


  // / Permet au parametre d'etre optionnel
  // / /<name|.*>'
  app.get('/<name|.*>', (Request request, String name) {
    return Response.ok('hello word ${name ?? ''}',
        headers: {'Content-Type': 'application/json'});
  });

  var handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(cors())
      .addMiddleware((handlerAuth(secret)))
      .addHandler(app);

  var server = await io.serve(handler, _hostname, port);
  print('Serving at http://${server.address.host}:${server.port}');
}
