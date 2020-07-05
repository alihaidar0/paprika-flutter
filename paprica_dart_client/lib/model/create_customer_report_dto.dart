part of swagger.api;

class CreateCustomerReportDto {
  
  int customerId = null;
  

  int reservationId = null;
  

  String description = null;
  
  CreateCustomerReportDto();

  @override
  String toString() {
    return 'CreateCustomerReportDto[customerId=$customerId, reservationId=$reservationId, description=$description, ]';
  }

  CreateCustomerReportDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    customerId =
        json['customerId']
    ;
    reservationId =
        json['reservationId']
    ;
    description =
        json['description']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'reservationId': reservationId,
      'description': description
     };
  }

  static List<CreateCustomerReportDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<CreateCustomerReportDto>() : json.map((value) => new CreateCustomerReportDto.fromJson(value)).toList();
  }

  static Map<String, CreateCustomerReportDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateCustomerReportDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CreateCustomerReportDto.fromJson(value));
    }
    return map;
  }
}

