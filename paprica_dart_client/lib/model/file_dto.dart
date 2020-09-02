part of swagger.api;

class FileDto {
  String name = null;

  String fileURL = null;

  FileDto();

  @override
  String toString() {
    return 'FileDto[name=$name, fileURL=$fileURL, ]';
  }

  FileDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    name = json['name'];
    fileURL = json['fileURL'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'fileURL': fileURL};
  }

  static List<FileDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<FileDto>()
        : json.map((value) => new FileDto.fromJson(value)).toList();
  }

  static Map<String, FileDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, FileDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new FileDto.fromJson(value));
    }
    return map;
  }
}
