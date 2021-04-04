part of swagger.api;

class SoftUpPaprikaInsideTypesInvoiceStatus {
  /// The underlying value of this enum member.
  int value;

  SoftUpPaprikaInsideTypesInvoiceStatus._internal(this.value);

  static SoftUpPaprikaInsideTypesInvoiceStatus number1_ =
      SoftUpPaprikaInsideTypesInvoiceStatus._internal(1);
  static SoftUpPaprikaInsideTypesInvoiceStatus number2_ =
      SoftUpPaprikaInsideTypesInvoiceStatus._internal(2);

  SoftUpPaprikaInsideTypesInvoiceStatus.fromJson(dynamic data) {
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

  static dynamic encode(SoftUpPaprikaInsideTypesInvoiceStatus data) {
    return data.value;
  }
}
