part of swagger.api;

class CreateEventDto {
  String name = null;

  bool isActive = null;

  String image = null;

  String description = null;

  DateTime time = null;

  CreateEventDto();

  @override
  String toString() {
    return 'CreateEventDto[name=$name, isActive=$isActive, image=$image, description=$description, time=$time, ]';
  }

  CreateEventDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    isActive = json['isActive'];
    image = json['image'];
    description = json['description'];
    time = json['time'] == null ? null : DateTime.parse(json['time']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isActive': isActive,
      'image': image,
      'description': description,
      'time': time == null ? '' : time.toUtc().toIso8601String()
    };
  }

  static List<CreateEventDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CreateEventDto>()
        : json.map((value) => new CreateEventDto.fromJson(value)).toList();
  }

  static Map<String, CreateEventDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateEventDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CreateEventDto.fromJson(value));
    }
    return map;
  }
}
