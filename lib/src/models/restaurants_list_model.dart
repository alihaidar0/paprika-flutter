import 'package:swagger/api.dart';

class RestaurantsListModel {
  List<RestaurantModel> items = [];

  RestaurantsListModel({this.items});

  RestaurantsListModel.fromPagedResultDtoRestaurantLiteDto(
      PagedResultDtoRestaurantLiteDto pagedResultDtoRestaurantLiteDto) {
    pagedResultDtoRestaurantLiteDto.items.forEach((RestaurantLiteDto item) {
      items.add(RestaurantModel.fromRestaurantLiteDto(item));
    });
  }

  RestaurantsListModel.fromMyPaprikaModel(ListPapricaItemDto restList) {
    restList.items.forEach((item) {
      items.add(RestaurantModel.fromMyPaprikaModel(item));
    });
  }
}

class RestaurantModel {
  String name;

  String logoImage;

  double restaurantRate;

  bool isOpen;

  int id;

  RestaurantModel({
    this.id,
    this.name,
    this.restaurantRate,
    this.logoImage,
    this.isOpen,
  });

  RestaurantModel.fromMyPaprikaModel(
      RestaurantInListPapricaItem myPaprikaRestaurantsList) {
    id = myPaprikaRestaurantsList.id;
    isOpen = myPaprikaRestaurantsList.isOpen;
    name = myPaprikaRestaurantsList.name;
    logoImage = myPaprikaRestaurantsList.logo;
    restaurantRate = myPaprikaRestaurantsList.rate;
  }

  RestaurantModel.fromRestaurantLiteDto(RestaurantLiteDto restaurantLiteDto) {
    id = restaurantLiteDto.id;
    logoImage = restaurantLiteDto.logoImage;
    restaurantRate = restaurantLiteDto.restaurantRate;
    name = restaurantLiteDto.name;
    isOpen = restaurantLiteDto.isOpen;
  }
}
