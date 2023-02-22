import 'package:carv_annotations/carv_annotations.dart';
import 'package:example/user.pb.dart';

part 'user_model.g.dart';

@ModelValidate([
  Validatable('name', Validator(ValidatorType.required)),
  Validatable('email', Validator(ValidatorType.required)),
  Validatable('email', Validator(ValidatorType.email)),
  Validatable('password', Validator(ValidatorType.required)),
  Validatable('password', Validator(ValidatorType.minLength, matcher: 6)),
  Validatable('password', Validator(ValidatorType.maxLength, matcher: 20)),
  Validatable('age', Validator(ValidatorType.min, matcher: 16)),
  Validatable('hobbies', Validator(ValidatorType.maxLength, matcher: 5)),
])
class UserModel {
  final User data;

  // document Id
  final String? uid;

  UserModel(this.data, {this.uid});
}
