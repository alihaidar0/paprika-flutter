part of swagger.api;

class ManagerEventDto {
  
  String name = null;
  

  bool isActive = null;
  

  String image = null;
  

  String description = null;
  

  DateTime time = null;
  

  int id = null;
  
  ManagerEventDto();

  @override
  String toString() {
    return 'ManagerEventDto[name=$name, isActive=$isActive, image=$image, description=$description, time=$time, id=$id, ]';
  }

  ManagerEventDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
    isActive =
        json['isActive']
    ;
    image =
        json['image']
    ;
    description =
        json['description']
    ;
    time = json['time'] == null ? null : DateTime.parse(json['time']);
    id =
        json['id']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isActive': isActive,
      'image': image,
      'description': description,
      'time': time == null ? '' : time.toUtc().toIso8601String(),
      'id': id
     };
  }

  static List<ManagerEventDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<ManagerEventDto>() : json.map((value) => new ManagerEventDto.fromJson(value)).toList();
  }

  static Map<String, ManagerEventDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, ManagerEventDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new ManagerEventDto.fromJson(value));
    }
    return map;
  }
}

