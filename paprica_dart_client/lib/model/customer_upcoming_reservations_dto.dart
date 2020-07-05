part of swagger.api;

class CustomerUpcomingReservationsDto {
  
  List<CustomerUpcomingReservationDto> upcoming = [];
  

  int totalCount = null;
  
  CustomerUpcomingReservationsDto();

  @override
  String toString() {
    return 'CustomerUpcomingReservationsDto[upcoming=$upcoming, totalCount=$totalCount, ]';
  }

  CustomerUpcomingReservationsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    upcoming =
      CustomerUpcomingReservationDto.listFromJson(json['upcoming'])
;
    totalCount =
        json['totalCount']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'upcoming': upcoming,
      'totalCount': totalCount
     };
  }

  static List<CustomerUpcomingReservationsDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<CustomerUpcomingReservationsDto>() : json.map((value) => new CustomerUpcomingReservationsDto.fromJson(value)).toList();
  }

  static Map<String, CustomerUpcomingReservationsDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerUpcomingReservationsDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CustomerUpcomingReservationsDto.fromJson(value));
    }
    return map;
  }
}

