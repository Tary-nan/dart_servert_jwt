import 'package:boilerplate_server_side_dart/src/auth/middleware/check_autorization.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class UserApi {
  DbCollection store;

  UserApi({this.store});

  Handler get router {
    final router = Router();

    router.get('/', (Request req) async {
      // detail account
      final accountDetail = req.context['account'] as JWT;
      final user = await store.findOne(
          where.eq('_id', ObjectId.fromHexString(accountDetail.subject)));

      print(user);
      Response.ok('{"users": [ "Bob", "Jayne", "John"]}',
          headers: {'Content-Type': 'application/json'});
    });

    var handler =
        const Pipeline().addMiddleware(checkAuthorization()).addHandler(router);
    return handler;
  }
}
