part of swagger.api;

class RestaurantUpcomingReservationsDto {
  
  List<RestaurantUpcomingReservationDto> reserved = [];
  

  List<RestaurantUpcomingReservationDto> pending = [];
  

  List<RestaurantUpcomingReservationDto> rejected = [];
  
  RestaurantUpcomingReservationsDto();

  @override
  String toString() {
    return 'RestaurantUpcomingReservationsDto[reserved=$reserved, pending=$pending, rejected=$rejected, ]';
  }

  RestaurantUpcomingReservationsDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reserved =
      RestaurantUpcomingReservationDto.listFromJson(json['reserved'])
;
    pending =
      RestaurantUpcomingReservationDto.listFromJson(json['pending'])
;
    rejected =
      RestaurantUpcomingReservationDto.listFromJson(json['rejected'])
;
  }

  Map<String, dynamic> toJson() {
    return {
      'reserved': reserved,
      'pending': pending,
      'rejected': rejected
     };
  }

  static List<RestaurantUpcomingReservationsDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<RestaurantUpcomingReservationsDto>() : json.map((value) => new RestaurantUpcomingReservationsDto.fromJson(value)).toList();
  }

  static Map<String, RestaurantUpcomingReservationsDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, RestaurantUpcomingReservationsDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new RestaurantUpcomingReservationsDto.fromJson(value));
    }
    return map;
  }
}

