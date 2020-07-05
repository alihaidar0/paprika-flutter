part of swagger.api;

class LiteSearchItemDto {
  int relatedItemId = null;

  String relatedImage = null;

  int itemType = null;

  //enum itemTypeEnum {  1,  2,  3,  };

  String text = null;

  LiteSearchItemDto();

  @override
  String toString() {
    return 'LiteSearchItemDto[relatedItemId=$relatedItemId, relatedImage=$relatedImage, itemType=$itemType, text=$text, ]';
  }

  LiteSearchItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    relatedItemId = json['relatedItemId'];
    relatedImage = json['relatedImage'];
    itemType = json['itemType'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    return {'relatedItemId': relatedItemId, 'relatedImage': relatedImage, 'itemType': itemType, 'text': text};
  }

  static List<LiteSearchItemDto> listFromJson(List<dynamic> json) {
    return json == null ? new List<LiteSearchItemDto>() : json.map((value) => new LiteSearchItemDto.fromJson(value)).toList();
  }

  static Map<String, LiteSearchItemDto> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, LiteSearchItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new LiteSearchItemDto.fromJson(value));
    }
    return map;
  }
}
