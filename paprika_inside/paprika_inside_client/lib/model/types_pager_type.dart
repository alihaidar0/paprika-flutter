part of swagger_inside.api;

class TypesPagerType {
  /// The underlying value of this enum member.
  int value;

  TypesPagerType._internal(this.value);

  static TypesPagerType number1_ = TypesPagerType._internal(1);
  static TypesPagerType number2_ = TypesPagerType._internal(2);

  TypesPagerType.fromJson(dynamic data) {
    switch (data) {
      case 1:
        value = data;
        break;
      case 2:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode: $data');
    }
  }

  static dynamic encode(TypesPagerType data) {
    return data.value;
  }
}
