part of swagger_inside.api;

class SoftUpPaprikaInsideTypesTaxType {
  /// The underlying value of this enum member.
  int value;

  SoftUpPaprikaInsideTypesTaxType._internal(this.value);

  static SoftUpPaprikaInsideTypesTaxType number1_ =
      SoftUpPaprikaInsideTypesTaxType._internal(1);
  static SoftUpPaprikaInsideTypesTaxType number2_ =
      SoftUpPaprikaInsideTypesTaxType._internal(2);

  SoftUpPaprikaInsideTypesTaxType.fromJson(dynamic data) {
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

  static dynamic encode(SoftUpPaprikaInsideTypesTaxType data) {
    return data.value;
  }
}
