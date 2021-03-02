import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

String generateSalt([int taille = 32]) {
  var aleatoire = Random.secure();
  var input = List<int>.generate(32, (_) => aleatoire.nextInt(256));
  return base64.encode(input);
}

String hashPassword({String password, String salt}) {
  final codec = Utf8Codec();
  final key = codec.encode(password);
  final saltBytes = codec.encode(salt);
  final hmac = Hmac(sha256, key);
  final digest = hmac.convert(saltBytes);
  return digest.toString();
}

String generateJwt({String subject, String issuer, String secret}) {
  String token;

  /* Sign */ {
    // Create a json web token
    final jwt = JWT({
      'iat': 123,
    }, issuer: issuer, subject: subject);

    // Sign it
    token = jwt.sign(SecretKey(secret));
    return token;
  }
}

dynamic verifyJWt({String token, String secret}) {
  /* Verify */ {
    try {
      // Verify a token
      final jwt = JWT.verify(token, SecretKey(secret));
      return jwt;
    } on JWTExpiredError {
      print('jwt expired');
    } on JWTError catch (ex) {
      print(ex.message); // ex: invalid signature
    }
  }
}
