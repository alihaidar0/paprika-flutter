part of swagger.api;

class OfferPapricaItemDto extends CustomerOfferDto {
  OfferPapricaItemDto();
  String restaurantLogo = null;
  @override
  String toString() {
    return 'OfferPapricaItemDto[restaurantId=$restaurantId, restaurantName=$restaurantName,restaurantLogo=$restaurantLogo, image=$image, description=$description, id=$id, ]';
  }

  OfferPapricaItemDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['restaurantId'];
    restaurantName = json['restaurantName'];
    restaurantLogo = json['restaurantLogo'];
    image = json['image'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'restaurantLogo': restaurantLogo,
      'image': image,
      'description': description,
      'id': id
    };
  }

  static List<OfferPapricaItemDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<OfferPapricaItemDto>()
        : json.map((value) => new OfferPapricaItemDto.fromJson(value)).toList();
  }

  static Map<String, OfferPapricaItemDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, OfferPapricaItemDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new OfferPapricaItemDto.fromJson(value));
    }
    return map;
  }

  OfferPapricaItemDto.fromCustomerOfferDto(CustomerOfferDto dto) {
    id = dto.id;
    restaurantName = dto.restaurantName;
    description = dto.description;
    image = dto.image;
    isActive = dto.isActive;
    restaurantId = dto.restaurantId;
    restaurantLogo = dto.restaurantImage;
  }


}
