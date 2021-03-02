import 'package:boilerplate_server_side_dart/src/auth/middleware/check_autorization.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class UserApi {
  Handler get router {
    final router = Router();

    router.get(
        '/',
        (Request req) => Response.ok('{"users": [ "Bob", "Jayne", "John"]}',
            headers: {'Content-Type': 'application/json'}));

    var handler =
        const Pipeline()
        .addMiddleware(checkAuthorization())
        .addHandler(router);
    return handler;
  }
}
