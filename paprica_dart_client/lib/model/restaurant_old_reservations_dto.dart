part of swagger.api;

class RestaurantOldReservationsDto {
  
  List<RestaurantOldReservationDto> oldReservations = [];
  
  RestaurantOldReservationsDto();

  @override
  String toString() {
    return 'RestaurantOldReservationsDto[oldReservations=$oldReservations, ]';
  }

  RestaurantOldReservationsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    oldReservations =
      RestaurantOldReservationDto.listFromJson(json['oldReservations'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'oldReservations': oldReservations
     };
  }

  static List<RestaurantOldReservationsDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<RestaurantOldReservationsDto>() : json.map((value) => new RestaurantOldReservationsDto.fromJson(value)).toList();
  }

  static Map<String, RestaurantOldReservationsDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantOldReservationsDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RestaurantOldReservationsDto.fromJson(value));
    }
    return map;
  }
}

