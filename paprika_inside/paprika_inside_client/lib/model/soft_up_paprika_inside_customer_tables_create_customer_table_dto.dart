part of swagger.api;

class SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto {
  String tableId = null;

  String customerId = null;

  String customerName = null;

  String customerPhone = null;

  SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto[tableId=$tableId, customerId=$customerId, customerName=$customerName, customerPhone=$customerPhone, ]';
  }

  SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    tableId = json['tableId'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    customerPhone = json['customerPhone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'tableId': tableId,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone
    };
  }

  static List<SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto>
      listFromJson(List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto
                    .fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto>
      mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String,
        SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto.fromJson(
              value));
    }
    return map;
  }
}
