part of swagger.api;

class SoftUpPaprikaInsideInvoicesInvoiceDto {
  String customerTableId = null;

  double total = null;

  double subTotal = null;

  SoftUpPaprikaInsideTypesInvoiceStatus status = null;

  String notes = null;

  List<SoftUpPaprikaInsideInvoicesInvoiceTaxDto> taxes = [];

  SoftUpPaprikaInsideInvoicesInvoiceDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideInvoicesInvoiceDto[customerTableId=$customerTableId, total=$total, subTotal=$subTotal, status=$status, notes=$notes, taxes=$taxes, ]';
  }

  SoftUpPaprikaInsideInvoicesInvoiceDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    customerTableId = json['customerTableId'];
    total = json['total'] == null ? null : json['total'].toDouble();
    subTotal = json['subTotal'] == null ? null : json['subTotal'].toDouble();
    status = new SoftUpPaprikaInsideTypesInvoiceStatus.fromJson(json['status']);
    notes = json['notes'];
    taxes =
        SoftUpPaprikaInsideInvoicesInvoiceTaxDto.listFromJson(json['taxes']);
  }

  Map<String, dynamic> toJson() {
    return {
      'customerTableId': customerTableId,
      'total': total,
      'subTotal': subTotal,
      'status': status,
      'notes': notes,
      'taxes': taxes
    };
  }

  static List<SoftUpPaprikaInsideInvoicesInvoiceDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideInvoicesInvoiceDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideInvoicesInvoiceDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideInvoicesInvoiceDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideInvoicesInvoiceDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new SoftUpPaprikaInsideInvoicesInvoiceDto.fromJson(value));
    }
    return map;
  }
}
