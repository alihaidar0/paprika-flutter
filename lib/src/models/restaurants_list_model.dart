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

  RestaurantsListModel.fromMyPapricaModel(ListPapricaItemDto restList) {
    restList.items.forEach((item) {
      items.add(RestaurantModel.fromMyPapricaModel(item));
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

  RestaurantModel.fromMyPapricaModel(
      RestaurantInListPapricaItem myPapricaRestaurantsList) {
    id = myPapricaRestaurantsList.id;
    isOpen = myPapricaRestaurantsList.isOpen;
    name = myPapricaRestaurantsList.name;
    logoImage = myPapricaRestaurantsList.logo;
    restaurantRate = myPapricaRestaurantsList.rate;
  }

  RestaurantModel.fromRestaurantLiteDto(RestaurantLiteDto restaurantLiteDto) {
    id = restaurantLiteDto.id;
    logoImage = restaurantLiteDto.logoImage;
    restaurantRate = restaurantLiteDto.restaurantRate;
    name = restaurantLiteDto.name;
    isOpen = restaurantLiteDto.isOpen;
  }
}
