part of swagger_inside.api;

class InvoicesInvoiceTaxDto {
  String name = null;

  TypesTaxType type = null;

  double value = null;

  InvoicesInvoiceTaxDto();

  @override
  String toString() {
    return 'InvoicesInvoiceTaxDto[name=$name, type=$type, value=$value, ]';
  }

  InvoicesInvoiceTaxDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    type = new TypesTaxType.fromJson(json['type']);
    value = json['value'] == null ? null : json['value'].toDouble();
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'type': type, 'value': value};
  }

  static List<InvoicesInvoiceTaxDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InvoicesInvoiceTaxDto>()
        : json
            .map((value) => new InvoicesInvoiceTaxDto.fromJson(value))
            .toList();
  }

  static Map<String, InvoicesInvoiceTaxDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InvoicesInvoiceTaxDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InvoicesInvoiceTaxDto.fromJson(value));
    }
    return map;
  }
}
