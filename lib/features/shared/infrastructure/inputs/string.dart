import 'package:formz/formz.dart';

// Define input validation errors
enum StringInputError { empty, tooShort, tooLong }

// Extend FormzInput and provide the input type and error type.
class StringInput extends FormzInput<String, StringInputError> {
  // Set minimum and maximum length requirements
  final int minLength;
  final int maxLength;

  // Constructor for unmodified form input
  const StringInput.pure({this.minLength = 3, this.maxLength = 100})
      : super.pure('');

  // Constructor for modified form input
  const StringInput.dirty(String value,
      {this.minLength = 3, this.maxLength = 100})
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == StringInputError.empty) return 'El campo es requerido';
    if (displayError == StringInputError.tooShort)
      return 'El texto es demasiado corto';
    if (displayError == StringInputError.tooLong)
      return 'El texto es demasiado largo';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  StringInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return StringInputError.empty;
    if (value.length < minLength) return StringInputError.tooShort;
    if (value.length > maxLength) return StringInputError.tooLong;

    return null;
  }
}
