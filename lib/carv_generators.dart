library carv_generators;

import 'package:build/build.dart';
import 'package:carv_generators/src/validate_generator.dart';
import 'package:source_gen/source_gen.dart';

/// A builder that generates code for validating models.
Builder generateValidatableExtension(BuilderOptions options) {
  return SharedPartBuilder(
    [ValidateGenerator()],
    'validatable_generator',
  );
}
