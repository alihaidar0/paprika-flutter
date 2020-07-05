part of swagger.api;

class CreateOfferDto {
  
  bool isActive = null;
  

  String image = null;
  

  String description = null;
  
  CreateOfferDto();

  @override
  String toString() {
    return 'CreateOfferDto[isActive=$isActive, image=$image, description=$description, ]';
  }

  CreateOfferDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    isActive =
        json['isActive']
    ;
    image =
        json['image']
    ;
    description =
        json['description']
    ;
  }

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'image': image,
      'description': description
     };
  }

  static List<CreateOfferDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<CreateOfferDto>() : json.map((value) => new CreateOfferDto.fromJson(value)).toList();
  }

  static Map<String, CreateOfferDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CreateOfferDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new CreateOfferDto.fromJson(value));
    }
    return map;
  }
}

