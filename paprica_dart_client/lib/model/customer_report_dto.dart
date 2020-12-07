part of swagger.api;

class CustomerReportDto {
  int reportId = null;

  int reservationId = null;

  int id = null;

  CustomerReportDto();

  @override
  String toString() {
    return 'CustomerReportDto[reportId=$reportId, reservationId=$reservationId, id=$id, ]';
  }

  CustomerReportDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reportId = json['reportId'];
    reservationId = json['reservationId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'reportId': reportId, 'reservationId': reservationId, 'id': id};
  }

  static List<CustomerReportDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerReportDto>()
        : json.map((value) => new CustomerReportDto.fromJson(value)).toList();
  }

  static Map<String, CustomerReportDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerReportDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerReportDto.fromJson(value));
    }
    return map;
  }
}
