part of swagger_inside.api;

class InvoicesInvoiceDto {
  String customerTableId = null;

  double total = null;

  double subTotal = null;

  TypesInvoiceStatus status = null;

  String notes = null;

  List<InvoicesInvoiceTaxDto> taxes = [];

  InvoicesInvoiceDto();

  @override
  String toString() {
    return 'InvoicesInvoiceDto[customerTableId=$customerTableId, total=$total, subTotal=$subTotal, status=$status, notes=$notes, taxes=$taxes, ]';
  }

  InvoicesInvoiceDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    customerTableId = json['customerTableId'];
    total = json['total'] == null ? null : json['total'].toDouble();
    subTotal = json['subTotal'] == null ? null : json['subTotal'].toDouble();
    status = new TypesInvoiceStatus.fromJson(json['status']);
    notes = json['notes'];
    taxes = InvoicesInvoiceTaxDto.listFromJson(json['taxes']);
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

  static List<InvoicesInvoiceDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InvoicesInvoiceDto>()
        : json.map((value) => new InvoicesInvoiceDto.fromJson(value)).toList();
  }

  static Map<String, InvoicesInvoiceDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InvoicesInvoiceDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InvoicesInvoiceDto.fromJson(value));
    }
    return map;
  }
}
