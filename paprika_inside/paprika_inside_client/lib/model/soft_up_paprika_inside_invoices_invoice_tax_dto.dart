part of swagger_inside.api;

class SoftUpPaprikaInsideInvoicesInvoiceTaxDto {
  String name = null;

  SoftUpPaprikaInsideTypesTaxType type = null;

  double value = null;

  SoftUpPaprikaInsideInvoicesInvoiceTaxDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideInvoicesInvoiceTaxDto[name=$name, type=$type, value=$value, ]';
  }

  SoftUpPaprikaInsideInvoicesInvoiceTaxDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    type = new SoftUpPaprikaInsideTypesTaxType.fromJson(json['type']);
    value = json['value'] == null ? null : json['value'].toDouble();
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'type': type, 'value': value};
  }

  static List<SoftUpPaprikaInsideInvoicesInvoiceTaxDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideInvoicesInvoiceTaxDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideInvoicesInvoiceTaxDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideInvoicesInvoiceTaxDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideInvoicesInvoiceTaxDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideInvoicesInvoiceTaxDto.fromJson(value));
    }
    return map;
  }
}
