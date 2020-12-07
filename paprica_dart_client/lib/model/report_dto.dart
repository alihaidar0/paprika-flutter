part of swagger.api;

class ReportDto {
  int restuarantId = null;

  int customerId = null;

  String description = null;

  int type = null;
  //enum typeEnum {  0,  1,  };

  RestaurantReportDto restaurantReport = null;

  CustomerReportDto customerReport = null;

  int id = null;

  ReportDto();

  @override
  String toString() {
    return 'ReportDto[restuarantId=$restuarantId, customerId=$customerId, description=$description, type=$type, restaurantReport=$restaurantReport, customerReport=$customerReport, id=$id, ]';
  }

  ReportDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restuarantId = json['restuarantId'];
    customerId = json['customerId'];
    description = json['description'];
    type = json['type'];
    restaurantReport =
        new RestaurantReportDto.fromJson(json['restaurantReport']);
    customerReport = new CustomerReportDto.fromJson(json['customerReport']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restuarantId': restuarantId,
      'customerId': customerId,
      'description': description,
      'type': type,
      'restaurantReport': restaurantReport,
      'customerReport': customerReport,
      'id': id
    };
  }

  static List<ReportDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<ReportDto>()
        : json.map((value) => new ReportDto.fromJson(value)).toList();
  }

  static Map<String, ReportDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ReportDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new ReportDto.fromJson(value));
    }
    return map;
  }
}
