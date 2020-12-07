part of swagger.api;

class PagedResultDtoReservationDto {
  int totalCount = null;

  List<ReservationDto> items = [];

  PagedResultDtoReservationDto();

  @override
  String toString() {
    return 'PagedResultDtoReservationDto[totalCount=$totalCount, items=$items, ]';
  }

  PagedResultDtoReservationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    totalCount = json['totalCount'];
    items = ReservationDto.listFromJson(json['items']);
  }

  Map<String, dynamic> toJson() {
    return {'totalCount': totalCount, 'items': items};
  }

  static List<PagedResultDtoReservationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<PagedResultDtoReservationDto>()
        : json
            .map((value) => new PagedResultDtoReservationDto.fromJson(value))
            .toList();
  }

  static Map<String, PagedResultDtoReservationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, PagedResultDtoReservationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new PagedResultDtoReservationDto.fromJson(value));
    }
    return map;
  }
}
