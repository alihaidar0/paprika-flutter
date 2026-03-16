part of swagger_inside.api;

class CustomerTablesCreateCustomerTableDto {
  String tableId = null;

  String customerId = null;

  String customerName = null;

  String customerPhone = null;

  CustomerTablesCreateCustomerTableDto();

  @override
  String toString() {
    return 'CustomerTablesCreateCustomerTableDto[tableId=$tableId, customerId=$customerId, customerName=$customerName, customerPhone=$customerPhone, ]';
  }

  CustomerTablesCreateCustomerTableDto.fromJson(Map<String, dynamic> json) {
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

  static List<CustomerTablesCreateCustomerTableDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<CustomerTablesCreateCustomerTableDto>()
        : json
            .map((value) =>
                new CustomerTablesCreateCustomerTableDto.fromJson(value))
            .toList();
  }

  static Map<String, CustomerTablesCreateCustomerTableDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerTablesCreateCustomerTableDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerTablesCreateCustomerTableDto.fromJson(value));
    }
    return map;
  }
}
