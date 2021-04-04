part of swagger_inside.api;

class SoftUpPaprikaInsideTypesPagerType {
  /// The underlying value of this enum member.
  int value;

  SoftUpPaprikaInsideTypesPagerType._internal(this.value);

  static SoftUpPaprikaInsideTypesPagerType number1_ =
      SoftUpPaprikaInsideTypesPagerType._internal(1);
  static SoftUpPaprikaInsideTypesPagerType number2_ =
      SoftUpPaprikaInsideTypesPagerType._internal(2);

  SoftUpPaprikaInsideTypesPagerType.fromJson(dynamic data) {
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

  static dynamic encode(SoftUpPaprikaInsideTypesPagerType data) {
    return data.value;
  }
}
