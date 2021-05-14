import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User{
  // class immutable
  const factory User({int id, String name, String email}) = _User;

// user json_serializable
  factory User.fromJson(Map<String, dynamic>json)=> _$UserFromJson(json);

}