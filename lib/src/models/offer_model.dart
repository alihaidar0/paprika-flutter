import 'package:swagger/api.dart';

class OffersListModel {
  List<OfferModel> items = [];

  OffersListModel({this.items});

  OffersListModel.fromMyPapricaModel(PagedResultDtoMyPapricaOfferDto restList) {
    restList.items.forEach((item) {
      items.add(OfferModel.fromMyPapricaEventDto(item));
    });
  }
}

class OfferModel {
//  String offerTitle,
//      restaurantName,
//      imageUrl,
//      description1,
//      description2,
//      description3,
//      price,
//      dateFrom,
//      dateTo;

  int id, restaurantId;

  String restaurantName, image, description, restaurantLogo;

  bool isActive;

  OfferModel(
      {this.restaurantName,
      this.description,
      this.image,
      this.id,
      this.isActive});

  OfferModel.fromCustomerOfferDto(CustomerOfferDto dto) {
    id = dto.id;
    restaurantName = dto.restaurantName;
    description = dto.description;
    image = dto.image;
    isActive = dto.isActive;
    restaurantId = dto.restaurantId;
    restaurantLogo = dto.restaurantImage;
  }

  OfferModel.fromMyPapricaEventDto(OfferPapricaItemDto dto) {
    id = dto.id;
    restaurantName = dto.restaurantName;
    description = dto.description;
    image = dto.image;
    isActive = dto.isActive;
    restaurantLogo = dto.restaurantLogo;
    restaurantId = dto.restaurantId;
  }
}
