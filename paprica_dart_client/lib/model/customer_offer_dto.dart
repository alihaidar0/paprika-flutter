part of swagger.api;

class CustomerOfferDto {
  int restaurantId = null;

  String restaurantName = null;

  bool isActive = null;

  String image = null;

  String description = null;

  String restaurantImage;
  int id = null;

  CustomerOfferDto();

  @override
  String toString() {
    return 'CustomerOfferDto[restaurantId=$restaurantId, restaurantName=$restaurantName, isActive=$isActive, image=$image, description=$description, id=$id, ]';
  }

  CustomerOfferDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    isActive = json['isActive'];
    image = json['image'];
    description = json['description'];
    restaurantImage = json['restaurantImage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'isActive': isActive,
      'image': image,
      'description': description,
      'restaurantImage': restaurantImage,
      'id': id
    };
  }

  static List<CustomerOfferDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<CustomerOfferDto>()
        : json.map((value) => new CustomerOfferDto.fromJson(value)).toList();
  }

  static Map<String, CustomerOfferDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, CustomerOfferDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new CustomerOfferDto.fromJson(value));
    }
    return map;
  }
}
