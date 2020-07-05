part of swagger.api;

class FileURLDto {
  
  String url = null;
  
  FileURLDto();

  @override
  String toString() {
    return 'FileURLDto[url=$url, ]';
  }

  FileURLDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    url =
        json['url']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url
     };
  }

  static List<FileURLDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<FileURLDto>() : json.map((value) => new FileURLDto.fromJson(value)).toList();
  }

  static Map<String, FileURLDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, FileURLDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new FileURLDto.fromJson(value));
    }
    return map;
  }
}

