import 'dart:io';

import 'package:boilerplate_server_side_dart/src/utils.dart';
import 'package:shelf/shelf.dart';

Middleware handlerAuth(String secret) {
  return (Handler innerHandler) {
    return (Request request) {
      var token, jwt;
      final authorization = request.headers[HttpHeaders.authorizationHeader];
      if (authorization != null && authorization.startsWith('Bearer ')) {
        token = authorization.substring(7);
        jwt = verifyJWt(token: token, secret: secret);
      }
      //if (authorization == null) return Response.notFound('account not found');
      return innerHandler(
        request.change(
          context: {...request.context, 'account': jwt},
        ),
      );
    };
  };
}

Middleware checkAuthorization() => createMiddleware(
  requestHandler: (Request request) 
    => (request.context['account'] != null) 
    ? null 
    : Response.forbidden('Not authorized to performs this action'),
);
