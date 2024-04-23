import 'package:formz/formz.dart';

enum TextError {
  empty,
}

class RequiredText extends FormzInput<String, TextError> {
  const RequiredText.pure() : super.pure('');
  const RequiredText.dirty({required String value}) : super.dirty(value);

  @override
  TextError? validator(String value) {
    return (value.trim().isEmpty) ? TextError.empty : null;
  }
}

enum DropdownError {
  empty,
}

class RequiredDropdown extends FormzInput<String?, DropdownError> {
  const RequiredDropdown.pure() : super.pure(null);
  const RequiredDropdown.dirty({required String? value}) : super.dirty(value);

  @override
  DropdownError? validator(String? value) {
    return ((value == null) || (value.isEmpty)) ? DropdownError.empty : null;
  }
}

enum ImageError {
  empty,
}

class RequiredImage extends FormzInput<String?, ImageError> {
  const RequiredImage.pure() : super.pure(null);
  const RequiredImage.dirty({required String? value}) : super.dirty(value);

  @override
  ImageError? validator(String? value) {
    return ((value == null) || (value.isEmpty)) ? ImageError.empty : null;
  }
}
