import 'package:paprika/src/models/create_pickup_meal_model.dart';
import 'package:swagger/api.dart';

class PickupModel {
  String restaurantName;
  String imageUrl;
  DateTime date;
  int id;
  int restaurantId;
  List<CustomerUpcomingPickupMealDto> upcomingPickupMeals = [];
  List<UpdatePickupMealRequestDto> updatePickupMealsRequest = [];
  List<CreatePickupMealModel> createPickupMeals = [];

  PickupModel({
    this.restaurantName,
    this.imageUrl,
    this.date,
    this.id,
    this.restaurantId,
    this.upcomingPickupMeals,
    this.updatePickupMealsRequest,
    this.createPickupMeals,
  });

  PickupModel.fromOld(CustomerOldPickupDto oldPickup) {
    imageUrl = oldPickup.restaurantImage;
    date = oldPickup.date;
    restaurantName = oldPickup.restaurantName;
    id = oldPickup.id;
    restaurantId = oldPickup.restaurantId;
  }

  PickupModel.fromUpcoming(CustomerUpcomingPickupDto upcomingPickup) {
    date = upcomingPickup.date;
    upcomingPickupMeals = upcomingPickup.pickupMeals;
    id = upcomingPickup.id;
  }

  PickupModel.fromUpdateRequest(UpdatePickupRequestDto updatePickupRequest) {
    date = updatePickupRequest.time;
    updatePickupMealsRequest = updatePickupRequest.pickupMeals;
    id = updatePickupRequest.pickupId;
  }
}
