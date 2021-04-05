part of swagger_inside.api;

class TypesTableStatus {
  /// The underlying value of this enum member.
  int value;

  TypesTableStatus._internal(this.value);

  static TypesTableStatus number1_ = TypesTableStatus._internal(1);
  static TypesTableStatus number2_ = TypesTableStatus._internal(2);
  static TypesTableStatus number3_ = TypesTableStatus._internal(3);

  TypesTableStatus.fromJson(dynamic data) {
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

  static dynamic encode(TypesTableStatus data) {
    return data.value;
  }
}
