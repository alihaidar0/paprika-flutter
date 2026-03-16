part of swagger.api;

class EventPapricaItemDto extends CustomerEventDto {
  String restaurantLogo = null;

  EventPapricaItemDto();

  @override
  String toString() {
    return 'EventPapricaItemDto[name=$name, restaurantId=$restaurantId, restaurantName=$restaurantName, restaurantLogo=$restaurantLogo, image=$image, description=$description, time=$time, id=$id, isReservable=$isReservable,]';
  }

  EventPapricaItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    restaurantLogo = json['restaurantLogo'];
    image = json['image'];
    description = json['description'];
    time =
        json['time'] == null ? null : DateTime.parse(json['time'].toString());
    id = json['id'];
    isReservable = json['isReservable'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'restaurantLogo': restaurantLogo,
      'image': image,
      'description': description,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'id': id,
      'isReservable': isReservable
    };
  }

  static List<EventPapricaItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<EventPapricaItemDto>()
        : json.map((value) => new EventPapricaItemDto.fromJson(value)).toList();
  }

  static Map<String, EventPapricaItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, EventPapricaItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new EventPapricaItemDto.fromJson(value));
    }
    return map;
  }
}
