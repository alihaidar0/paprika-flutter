part of swagger.api;

class MediaDto {
  
  String name = null;
  
  MediaDto();

  @override
  String toString() {
    return 'MediaDto[name=$name, ]';
  }

  MediaDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name =
        json['name']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name
     };
  }

  static List<MediaDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<MediaDto>() : json.map((value) => new MediaDto.fromJson(value)).toList();
  }

  static Map<String, MediaDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, MediaDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new MediaDto.fromJson(value));
    }
    return map;
  }
}

