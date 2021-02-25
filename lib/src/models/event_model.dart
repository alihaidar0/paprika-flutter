import 'package:swagger/api.dart';

class EventModel {
  String eventName,
      bandName,
      restaurantName,
      imageUrl,
      description,
      restaurantLogo;
  EventModel offer;
  DateTime date;
  int id, restaurantId, maxPeopleAllowed;
  bool isReservable;

  EventModel(
      {this.imageUrl,
      this.eventName,
      this.bandName,
      this.restaurantName,
      this.date,
      this.description,
      this.offer,
      this.isReservable,
      this.restaurantLogo,
      this.maxPeopleAllowed});

  EventModel.fromRestaurantEventDto(RestaurantEventDto dto) {
    id = dto.id;
    imageUrl = dto.image;
    eventName = dto.name;
    restaurantName = dto.restaurantName;
    date = dto.time;
    description = dto.description;
    restaurantId = dto.restaurantId;
  }

  EventModel.fromEventPaprikaItemDto(EventPapricaItemDto dto) {
    id = dto.id;
    imageUrl = dto.image;
    eventName = dto.name;
    restaurantName = dto.restaurantName;
    date = dto.time;
    description = dto.description;
    restaurantId = dto.restaurantId;
    isReservable = dto.isReservable;
    restaurantLogo = dto.restaurantLogo;
  }

  EventModel.fromCustomerEventDto(CustomerEventDto dto) {
    id = dto.id;
    imageUrl = dto.image;
    eventName = dto.name;
    restaurantName = dto.restaurantName;
    restaurantLogo = dto.restaurantImage;
    date = dto.time;
    description = dto.description;
    restaurantId = dto.restaurantId;
    isReservable = dto.isReservable;
    maxPeopleAllowed = dto.maxPeopleAllowed;
  }
}
