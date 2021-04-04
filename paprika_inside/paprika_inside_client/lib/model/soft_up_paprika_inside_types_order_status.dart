part of swagger_inside.api;

class SoftUpPaprikaInsideTypesOrderStatus {
  /// The underlying value of this enum member.
  int value;

  SoftUpPaprikaInsideTypesOrderStatus._internal(this.value);

  static SoftUpPaprikaInsideTypesOrderStatus number1_ =
      SoftUpPaprikaInsideTypesOrderStatus._internal(1);
  static SoftUpPaprikaInsideTypesOrderStatus number2_ =
      SoftUpPaprikaInsideTypesOrderStatus._internal(2);
  static SoftUpPaprikaInsideTypesOrderStatus number3_ =
      SoftUpPaprikaInsideTypesOrderStatus._internal(3);

  SoftUpPaprikaInsideTypesOrderStatus.fromJson(dynamic data) {
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

  static dynamic encode(SoftUpPaprikaInsideTypesOrderStatus data) {
    return data.value;
  }
}
