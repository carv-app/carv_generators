import 'package:example/user.pb.dart';
import 'package:example/user_model.dart';

void main(List<String> arguments) {
  final user = UserModel(User(
      name: 'John',
      email: 'j@j.com',
      age: 10,
      hobbies: ['a', 'b', 'c', 'd', 'e', 'f']));

  user.validate();
}
