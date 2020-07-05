part of swagger.api;

class AntdImageDto {
  
  String imageUrl = null;
  

  String thumnailURL = null;
  

  int uploadStatus = null;
  //enum uploadStatusEnum {  1,  2,  };

  String name = null;
  

  String fileURL = null;
  
  AntdImageDto();

  @override
  String toString() {
    return 'AntdImageDto[imageUrl=$imageUrl, thumnailURL=$thumnailURL, uploadStatus=$uploadStatus, name=$name, fileURL=$fileURL, ]';
  }

  AntdImageDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    imageUrl =
        json['imageUrl']
    ;
    thumnailURL =
        json['thumnailURL']
    ;
    uploadStatus =
        json['uploadStatus']
    ;
    name =
        json['name']
    ;
    fileURL =
        json['fileURL']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'thumnailURL': thumnailURL,
      'uploadStatus': uploadStatus,
      'name': name,
      'fileURL': fileURL
     };
  }

  static List<AntdImageDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<AntdImageDto>() : json.map((value) => new AntdImageDto.fromJson(value)).toList();
  }

  static Map<String, AntdImageDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AntdImageDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new AntdImageDto.fromJson(value));
    }
    return map;
  }
}

