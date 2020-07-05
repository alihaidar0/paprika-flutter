part of swagger.api;

class CustomerEventDto {
  String name = null;

  int restaurantId = null;
  int maxPeopleAllowed = null;

  String restaurantName = null;
  String restaurantImage = null;

  bool isActive = null;

  String image = null;

  String description = null;

  DateTime time = null;

  int id = null;

  bool isReservable = null;

  CustomerEventDto();

  @override
  String toString() {
    return 'CustomerEventDto[name=$name, restaurantId=$restaurantId, restaurantName=$restaurantName,restaurantImage=$restaurantImage,maxPeopleAllowed=$maxPeopleAllowed, isActive=$isActive, image=$image, description=$description, time=$time, id=$id, isReservable=$isReservable,]';
  }

  CustomerEventDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    restaurantImage = json['restaurantImage'];
    isActive = json['isActive'];
    image = json['image'];
    maxPeopleAllowed = json['maxPeopleAllowed'];
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
      'restaurantImage': restaurantImage,
      'isActive': isActive,
      'image': image,
      'description': description,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'id': id,
      'maxPeopleAllowed': maxPeopleAllowed,
      'isReservable': isReservable
    };
  }

  static List<CustomerEventDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerEventDto>()
        : json.map((value) => new CustomerEventDto.fromJson(value)).toList();
  }

  static Map<String, CustomerEventDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerEventDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerEventDto.fromJson(value));
    }
    return map;
  }
}
