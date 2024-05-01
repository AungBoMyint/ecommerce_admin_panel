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

enum ObjectListError {
  empty,
}

class RequiredObjectList<T> extends FormzInput<List<T>, ObjectListError> {
  const RequiredObjectList.pure() : super.pure(const []);
  const RequiredObjectList.dirty({required List<T> value}) : super.dirty(value);

  @override
  ObjectListError? validator(List<T> value) {
    return value.isEmpty ? ObjectListError.empty : null;
  }
}

enum ObjectError {
  empty,
}

class RequiredObject<T> extends FormzInput<T?, ObjectError> {
  const RequiredObject.pure() : super.pure(null);
  const RequiredObject.dirty({required T value}) : super.dirty(value);

  @override
  ObjectError? validator(T? value) {
    return value == null ? ObjectError.empty : null;
  }
}

enum DoubleError {
  mustBeGreaterThanZero,
}

class RequiredDouble extends FormzInput<double, DoubleError> {
  const RequiredDouble.pure() : super.pure(0);
  const RequiredDouble.dirty({required double value}) : super.dirty(value);

  @override
  DoubleError? validator(double value) {
    return value < 1 ? DoubleError.mustBeGreaterThanZero : null;
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
