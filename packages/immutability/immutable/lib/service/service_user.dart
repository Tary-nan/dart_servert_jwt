import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:immutable/user.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class UserService extends Service {
  @override
  Future<Either<Failure, List<User>>> browser() async{
    try {
      final url = 'https://jsonplaceholder.typicode.com/users';
      final List data = json.decode((await http.get(Uri.parse(url))).body);
      print(data.runtimeType);
      final users = data.map((user) => User.fromJson(user)).toList();

      return right(users);

    } on SocketException{
      throw left(FailureSocketException('no internet'));
    } on FailureHttpException{
       throw left(FailureHttpException('http exception'));
    } on FormatException{
      throw left(FailureFormatException('data not found'));
    } catch (e){
      throw FailureUnknowException('unknow exception');
    }
  }

}
abstract class Service {
  Future<Either<Failure, List<User>>> browser();
}

class Failure implements Exception {}

@immutable
class FailureSocketException  extends Failure{
  final String error;
  FailureSocketException(this.error);

  @override
  String toString() {
    return 'Error : $error';
  }
}

@immutable
class FailureHttpException  extends Failure{
  final String error;
  FailureHttpException(this.error);

   @override
  String toString() {
    return 'Error : $error';
  }
}

@immutable
class FailureFormatException  extends Failure{
  final String error;
  FailureFormatException(this.error);

   @override
  String toString() {
    return 'Error : $error';
  }
}

@immutable
class FailureUnknowException  extends Failure{
  final String error;
  FailureUnknowException(this.error);

   @override
  String toString() {
    return 'Error : $error';
  }
}