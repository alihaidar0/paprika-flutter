part of swagger_inside.api;

class SoftUpPaprikaInsideTypesRestaurantStatus {
  /// The underlying value of this enum member.
  int value;

  SoftUpPaprikaInsideTypesRestaurantStatus._internal(this.value);

  static SoftUpPaprikaInsideTypesRestaurantStatus number1_ =
      SoftUpPaprikaInsideTypesRestaurantStatus._internal(1);
  static SoftUpPaprikaInsideTypesRestaurantStatus number2_ =
      SoftUpPaprikaInsideTypesRestaurantStatus._internal(2);

  SoftUpPaprikaInsideTypesRestaurantStatus.fromJson(dynamic data) {
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

  static dynamic encode(SoftUpPaprikaInsideTypesRestaurantStatus data) {
    return data.value;
  }
}
