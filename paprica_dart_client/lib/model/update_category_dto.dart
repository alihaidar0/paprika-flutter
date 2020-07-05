part of swagger.api;

class UpdateCategoryDto {
  
  int id = null;
  

  String name = null;
  

  String image = null;
  

  bool isActive = null;
  

  int sequenceNumber = null;
  
  UpdateCategoryDto();

  @override
  String toString() {
    return 'UpdateCategoryDto[id=$id, name=$name, image=$image, isActive=$isActive, sequenceNumber=$sequenceNumber, ]';
  }

  UpdateCategoryDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id =
        json['id']
    ;
    name =
        json['name']
    ;
    image =
        json['image']
    ;
    isActive =
        json['isActive']
    ;
    sequenceNumber =
        json['sequenceNumber']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isActive': isActive,
      'sequenceNumber': sequenceNumber
     };
  }

  static List<UpdateCategoryDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<UpdateCategoryDto>() : json.map((value) => new UpdateCategoryDto.fromJson(value)).toList();
  }

  static Map<String, UpdateCategoryDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, UpdateCategoryDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new UpdateCategoryDto.fromJson(value));
    }
    return map;
  }
}

