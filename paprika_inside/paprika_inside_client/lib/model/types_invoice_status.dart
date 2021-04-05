part of swagger_inside.api;

class TypesInvoiceStatus {
  /// The underlying value of this enum member.
  int value;

  TypesInvoiceStatus._internal(this.value);

  static TypesInvoiceStatus number1_ = TypesInvoiceStatus._internal(1);
  static TypesInvoiceStatus number2_ = TypesInvoiceStatus._internal(2);

  TypesInvoiceStatus.fromJson(dynamic data) {
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

  static dynamic encode(TypesInvoiceStatus data) {
    return data.value;
  }
}
