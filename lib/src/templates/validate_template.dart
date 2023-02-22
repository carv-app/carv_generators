// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:analyzer/dart/constant/value.dart';
import 'package:carv_generators/src/templates/template_base.dart';
import 'package:source_gen/source_gen.dart';

/// Generates the extension for validating the model
///
class ModelValidateExtensionTemplate implements TemplateBase {
  /// The model class with data
  final AnnotatedElement modelClass;

  const ModelValidateExtensionTemplate(this.modelClass);

  @override
  String generate() {
    final buffer = StringBuffer();

    // get the validators
    final validators = modelClass.annotation.read('validators').listValue;

    buffer.writeln(
        'extension _\$${modelClass.element.displayName}Validator on ${modelClass.element.displayName} {');

    buffer.writeln('Future<void> validate() async {');
    // generate the validation rules
    for (var validator in validators) {
      buffer.writeln(_generateValidationRule(validator));
    }
    buffer.writeln('}');
    buffer.writeln('}');

    return buffer.toString();
  }

  /// Generates the validation rule for the given validator
  String _generateValidationRule(DartObject validatorObj) {
    final varName = validatorObj.getField('name')!.toStringValue()!;
    final validatorName = validatorObj
        .getField('validator')!
        .getField('type')!
        .getField('_name')!
        .toStringValue();
    final validatorMatcher =
        validatorObj.getField('validator')!.getField('matcher');

    switch (validatorName) {
      case 'required':
        return _generateRuleForRequiredField(varName);
      case 'email':
        return _generateRuleForEmailField(varName);
      case 'minLength':
        return _generateRuleForMinLengthField(
            varName, validatorMatcher!.toIntValue()!);
      case 'maxLength':
        return _generateRuleForMaxLengthField(
            varName, validatorMatcher!.toIntValue()!);
      case 'min':
        return _generateRuleForMinField(
            varName,
            (validatorMatcher!.toDoubleValue() ??
                validatorMatcher.toIntValue())!);
      case 'max':
        return _generateRuleForMaxField(
            varName,
            (validatorMatcher!.toDoubleValue() ??
                validatorMatcher.toIntValue())!);
      default:
        return '';
    }
  }

  /// Generates the rule for validating a required field
  String _generateRuleForRequiredField(String varName) {
    return 'if (data.$varName == null) { throw ArgumentError("Field \'$varName\' is required but missing."); }';
  }

  /// Generates the rule for validating an email field
  String _generateRuleForEmailField(String varName) {
    return 'if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&\'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\\.[a-zA-Z]+").hasMatch(data.$varName)) { throw ArgumentError("Field \'$varName\' is not a valid email address."); }';
  }

  /// Generates the rule for validating a minimum length field
  String _generateRuleForMinLengthField(String varName, int length) {
    return 'if (data.$varName != null && data.$varName!.length < $length) { throw ArgumentError("Field \'$varName\' must be at least $length characters long."); }';
  }

  /// Generates the rule for validating a maximum length field
  String _generateRuleForMaxLengthField(String varName, int length) {
    return 'if (data.$varName != null && data.$varName!.length > $length) { throw ArgumentError("Field \'$varName\' must be at most $length characters long."); }';
  }

  /// Generates the rule for validating a minimum value field
  String _generateRuleForMinField(String varName, num min) {
    return 'if (data.$varName != null && data.$varName! < $min) { throw ArgumentError("Field \'$varName\' must be at least $min."); }';
  }

  /// Generates the rule for validating a maximum value field
  String _generateRuleForMaxField(String varName, num max) {
    return 'if (data.$varName != null && data.$varName! > $max) { throw ArgumentError("Field \'$varName\' must be at most $max."); }';
  }
}
