part of swagger_inside.api;

class TypesOrderStatus {
  /// The underlying value of this enum member.
  int value;

  TypesOrderStatus._internal(this.value);

  static TypesOrderStatus number1_ = TypesOrderStatus._internal(1);
  static TypesOrderStatus number2_ = TypesOrderStatus._internal(2);
  static TypesOrderStatus number3_ = TypesOrderStatus._internal(3);

  TypesOrderStatus.fromJson(dynamic data) {
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

  static dynamic encode(TypesOrderStatus data) {
    return data.value;
  }
}
