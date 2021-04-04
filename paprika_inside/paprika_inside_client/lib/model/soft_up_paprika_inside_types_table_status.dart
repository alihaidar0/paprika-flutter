part of swagger.api;

class SoftUpPaprikaInsideTypesTableStatus {
  /// The underlying value of this enum member.
  int value;

  SoftUpPaprikaInsideTypesTableStatus._internal(this.value);

  static SoftUpPaprikaInsideTypesTableStatus number1_ =
      SoftUpPaprikaInsideTypesTableStatus._internal(1);
  static SoftUpPaprikaInsideTypesTableStatus number2_ =
      SoftUpPaprikaInsideTypesTableStatus._internal(2);
  static SoftUpPaprikaInsideTypesTableStatus number3_ =
      SoftUpPaprikaInsideTypesTableStatus._internal(3);

  SoftUpPaprikaInsideTypesTableStatus.fromJson(dynamic data) {
    switch (data) {
      case 1:
        value = data;
        break;
      case 2:
        value = data;
        break;
      case 3:
        value = data;
        break;
      default:
        throw ('Unknown enum value to decode: $data');
    }
  }

  static dynamic encode(SoftUpPaprikaInsideTypesTableStatus data) {
    return data.value;
  }
}
