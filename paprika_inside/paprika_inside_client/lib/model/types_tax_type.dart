part of swagger_inside.api;

class TypesTaxType {
  /// The underlying value of this enum member.
  int value;

  TypesTaxType._internal(this.value);

  static TypesTaxType number1_ = TypesTaxType._internal(1);
  static TypesTaxType number2_ = TypesTaxType._internal(2);

  TypesTaxType.fromJson(dynamic data) {
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

  static dynamic encode(TypesTaxType data) {
    return data.value;
  }
}
