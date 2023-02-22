// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'dart:async';

import 'package:build/build.dart';
import 'package:carv_annotations/carv_annotations.dart';
import 'package:carv_generators/src/templates/validate_template.dart';
import 'package:source_gen/source_gen.dart';

const _modelValidateChecker = TypeChecker.fromRuntime(ModelValidate);

class ValidateGenerator extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) {
    late AnnotatedElement modelClass;

    try {
      modelClass = library.annotatedWith(_modelValidateChecker).first;

      final template = ModelValidateExtensionTemplate(modelClass);
      return template.generate();
    } catch (e) {
      // if e is StateError, it means that the modelClass is not found. ignoring it.
      if (e is! StateError) {
        log.info(e.toString());
      }

      return null;
    }
  }
}
