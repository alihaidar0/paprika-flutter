part of swagger_inside.api;

class TypesRestaurantStatus {
  /// The underlying value of this enum member.
  int value;

  TypesRestaurantStatus._internal(this.value);

  static TypesRestaurantStatus number1_ = TypesRestaurantStatus._internal(1);
  static TypesRestaurantStatus number2_ = TypesRestaurantStatus._internal(2);

  TypesRestaurantStatus.fromJson(dynamic data) {
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

  static dynamic encode(TypesRestaurantStatus data) {
    return data.value;
  }
}
