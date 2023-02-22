// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// ValidateGenerator
// **************************************************************************

extension $UserModelValidator on UserModel {
  Future<void> validate() async {
    if (data.name == null) {
      throw ArgumentError("Field 'name' is required but missing.");
    }
    if (data.email == null) {
      throw ArgumentError("Field 'email' is required but missing.");
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(data.email)) {
      throw ArgumentError("Field 'email' is not a valid email address.");
    }
    if (data.password == null) {
      throw ArgumentError("Field 'password' is required but missing.");
    }
    if (data.password != null && data.password!.length < 6) {
      throw ArgumentError(
          "Field 'password' must be at least 6 characters long.");
    }
    if (data.password != null && data.password!.length > 20) {
      throw ArgumentError(
          "Field 'password' must be at most 20 characters long.");
    }
    if (data.age != null && data.age! < 16) {
      throw ArgumentError("Field 'age' must be at least 16.");
    }
    if (data.hobbies != null && data.hobbies!.length > 5) {
      throw ArgumentError("Field 'hobbies' must be at most 5 characters long.");
    }
  }
}
