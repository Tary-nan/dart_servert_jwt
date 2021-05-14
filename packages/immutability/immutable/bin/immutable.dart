
// id - name - email
//
import 'package:immutable/service/service_user.dart';

void main(List<String> arguments) async{
  print('''
  /// *******************************
  /// IMMUTABILITY IN DART
  ///
  ''');
  try {
      final userService = await UserService().browser();
       print(userService.fold(
        (error){
          print('-----------error haut --------');
          return error.toString();
        }, 
        (data) => data.toList())
      );
    } catch(fail) {
      print('-----------error --------');
      print(fail.toString());
    } 

 

}
