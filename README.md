[![Pub Package](https://img.shields.io/pub/v/carv_generators.svg)](https://pub.dev/packages/carv_generators)

Provides [Dart Build System] builders for Generating boilerplate code for Carv app.

The builders generate code when they find classes/functions annotated with classes defined in [package:carv_annotations].

## Supporting Builders
    - Model Validate function (will be generate as an Extension)

## Setup

To configure your project with carv_generators follow these steps;

Add dependencies in your `pubspec.yaml` file.

```yaml
dependencies:
    carv_annotations: ^latest-version

dev_dependencies:
    build_runner:
    carv_generators: ^latest-version
```

create a `build.yaml` file in the root app folder and add the below code block.

```yaml
targets:
  $default:
    builders:
      carv_generators|modelValidatableGenerator:
        enabled: true
        generate_for:
          - lib/**_model.dart
```

Given your Domain model is `meeting_model.dart`:

```dart
import 'package:carv_annotations/carv_annotations.dart';

part 'meeting_model.g.dart';

@ModelValidate([
    Validatable('name', Validator(ValidatorType.required)),
    Validatable('email', Validator(ValidatorType.email)),
    Validatable('password', Validator(ValidatorType.minLength, matcher: 8)),
])
class MeetingModel {
  @override
  final Meeting data; // your pb data model :-> Meeting(name, email, password)

    // the rest of the code
    // goes below
}
```

Then run the following command to generate code for you.

```bash
flutter pub run build_runner build
```

or

```bash
flutter pub run build_runner build --delete-conflicting-outputs 
```

### TODO: 
    - Improve test coverage
    - Add more generators

[dart build system]: https://github.com/dart-lang/build
[package:carv_annotations]: https://pub.dev/packages/carv_annotations