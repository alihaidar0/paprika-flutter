import 'package:paprica/src/models/create_delivery_meal_model.dart';
import 'package:swagger/api.dart';

class DeliveryModel {
  String restaurantName;
  String imageUrl;
  int id;
  int restaurantId;
  double customerLongitude;
  double customerLatitude;
  String customerAddress;
  DateTime estimationTime;
  List<CustomerUpcomingDeliveryMealDto> upcomingDeliveryMeals = [];
  List<UpdateDeliveryMealRequestDto> updateDeliveryMealsRequest = [];
  List<CreateDeliveryMealModel> createDeliveryMeals = [];

  DeliveryModel({
    this.restaurantName,
    this.imageUrl,
    this.id,
    this.restaurantId,
    this.customerLongitude,
    this.customerLatitude,
    this.customerAddress,
    this.estimationTime,
    this.upcomingDeliveryMeals,
    this.updateDeliveryMealsRequest,
    this.createDeliveryMeals,
  });

  DeliveryModel.fromOld(CustomerOldDeliveryDto oldDelivery) {
    imageUrl = oldDelivery.restaurantImage;
    restaurantName = oldDelivery.restaurantName;
    id = oldDelivery.id;
    restaurantId = oldDelivery.restaurantId;
  }

  DeliveryModel.fromUpcoming(CustomerUpcomingDeliveryDto upcomingDelivery) {
    restaurantName = upcomingDelivery.restaurantName;
    id = upcomingDelivery.id;
    restaurantId = upcomingDelivery.restaurantId;
    customerLongitude = upcomingDelivery.customerLongitude;
    customerLatitude = upcomingDelivery.customerLatitude;
    customerAddress = upcomingDelivery.customerAddress;
    estimationTime = upcomingDelivery.estimationTime;
    upcomingDeliveryMeals = upcomingDelivery.deliveryMeals;
  }

  DeliveryModel.fromUpdateRequest(
      CustomerUpcomingDeliveryDto upcomingDelivery) {
    restaurantName = upcomingDelivery.restaurantName;
    id = upcomingDelivery.updateRequest.deliveryId;
    restaurantId = upcomingDelivery.restaurantId;
    customerLongitude = upcomingDelivery.updateRequest.Longitude;
    customerLatitude = upcomingDelivery.updateRequest.Latitude;
    customerAddress = upcomingDelivery.updateRequest.address;
    estimationTime = upcomingDelivery.estimationTime;
    updateDeliveryMealsRequest = upcomingDelivery.updateRequest.deliveryMeals;
  }
}
