import 'package:swagger/api.dart';

class ReservationModel {
  String restaurantName, imageUrl, moreInfo, personName, phoneNumber;
  DateTime date;
  int numberOfPeople;
  int id;
  int restaurantId;

  ReservationModel(
      {this.imageUrl,
      this.date,
      this.numberOfPeople,
      this.restaurantName,
      this.moreInfo,
      this.personName,
      this.phoneNumber});

  ReservationModel.fromReservationPapricaItemDto(
      ReservationPapricaItemDto papricaReservation) {
    numberOfPeople = papricaReservation.numberOfPeople;
    date = papricaReservation.time;
    restaurantName = papricaReservation.restaurantName;
    id = papricaReservation.id;
  }

  ReservationModel.fromOld(CustomerOldReservationDto oldReservation) {
    imageUrl = oldReservation.restaurantImage;
    numberOfPeople = oldReservation.numberOfPeople;
    date = oldReservation.date;
    restaurantName = oldReservation.restaurantName;
    moreInfo = oldReservation.customerAdditionalInfo;
    id = oldReservation.id;
    restaurantId = oldReservation.restaurantId;
  }

  ReservationModel.fromUpcoming(
      CustomerUpcomingReservationDto upcomingReservation) {
    imageUrl = upcomingReservation.restaurantImage;
    numberOfPeople = upcomingReservation.numberOfPeople;
    date = upcomingReservation.date;
    restaurantName = upcomingReservation.restaurantName;
    moreInfo = upcomingReservation.customerAdditionalInfo;
    id = upcomingReservation.id;
  }

  ReservationModel.fromUpdateRequest(UpdateReservationRequestDto reservation,
      int reservationId, String restaurantName, String imageUrl) {
    numberOfPeople = reservation.numberOfPeople;
    date = reservation.time;
    moreInfo = reservation.customerAdditionalInfo;
    restaurantName = restaurantName;
    imageUrl = imageUrl;
    id = reservationId;
  }
}
