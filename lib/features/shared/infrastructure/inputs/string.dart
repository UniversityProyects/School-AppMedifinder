import 'package:formz/formz.dart';

enum StringInputError { empty, tooShort, tooLong, invalidCharacters }

class StringInput extends FormzInput<String, StringInputError> {
  final int minLength;
  final int maxLength;

  const StringInput.pure({this.minLength = 3, this.maxLength = 100})
      : super.pure('');

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
    if (displayError == StringInputError.invalidCharacters)
      return 'Solo se permiten letras y espacios';

    return null;
  }

  @override
  StringInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return StringInputError.empty;
    if (value.length < minLength) return StringInputError.tooShort;
    if (value.length > maxLength) return StringInputError.tooLong;
    if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(value)) {
      return StringInputError.invalidCharacters;
    }

    return null;
  }
}
