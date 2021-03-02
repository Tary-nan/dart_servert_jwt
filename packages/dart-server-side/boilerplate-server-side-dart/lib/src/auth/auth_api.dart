import 'dart:convert';
import 'dart:io';

import 'package:boilerplate_server_side_dart/src/utils.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class AuthApi {
  DbCollection store;
  String secret;

  AuthApi({this.store, this.secret});

  Router get router {
    final router = Router();

    router.post('/account', (Request request) async {
      final data = json.decode(await request.readAsString());
      if (data is! Map) return Response(HttpStatus.badRequest);

      Map body = data as Map<String, dynamic>;
      // Response 400 Bad request
      if (!body.containsKey('email') && !body.containsKey('password'))
        return Response(HttpStatus.badRequest);

      final email = body['email'] as String;
      final password = (body['password'] as String);
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        // Response 400 Bad request
        return Response(HttpStatus.badRequest,
            body: 'put email et password valide');
      }

      // user already existing ??

      final user = await store.findOne(where.eq('email', email));
      if (user != null)
        return Response(HttpStatus.conflict); // Response 409 conflict

      // create user
      final salt = generateSalt();

      await store.save({
        'email': email,
        'password': hashPassword(password: password, salt: salt),
        'salt': salt
      });

      return Response.ok('register succefully'); // Response 200
    });

    router.post('/login', (Request request) async {
      final data = json.decode(await request.readAsString());
      if (data is! Map) return Response(HttpStatus.badRequest);

      Map body = data as Map<String, dynamic>;
      // Response 400 Bad request
      if (!body.containsKey('email') && !body.containsKey('password'))
        return Response(HttpStatus.badRequest);

      final email = body['email'] as String;
      final password = (body['password'] as String);
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        // Response 400 Bad request
        return Response(HttpStatus.badRequest,
            body: 'put email et password valide');
      }

      // user already existing ??

      final user = await store.findOne(where.eq('email', email));
      if (user != null) {
        // comparer le hashPassword
        final hashPwd = hashPassword(password: password, salt: user['salt']);
        if (hashPwd != user['password']) {
          return Response.forbidden(
              'Incorrect email and /or password'); // Response 403
        }
      }

      // Generate JWT and send with response
      final userId = (user['_id'] as ObjectId).toHexString();
      final token = generateJwt(subject: userId, secret: secret, issuer: 'http://localhost:8080');

      // loggin successfully

      return Response.ok(json.encode({'token': token}), headers: {
        HttpHeaders.contentTypeHeader : ContentType.json.mimeType
      }); // Response 200
    });

    return router;
  }
}
