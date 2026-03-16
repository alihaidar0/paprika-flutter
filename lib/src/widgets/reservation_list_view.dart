import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paprika/src/models/reservation_model.dart';
import 'package:paprika/src/widgets/reservation_card.dart';

class ReservationsListView extends StatelessWidget {
  final List<ReservationModel> reservationsList;
  final GestureTapCallback deleteCallback;

  ReservationsListView({
    this.reservationsList,
    this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var x = 0; x < reservationsList.length; x++) {
      widgets.add(
        Container(
          child: _buildReservationCard(context, x),
        ),
      );
    }
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(5.0),
        shrinkWrap: true,
        children: widgets,
      ),
    );
  }

  Widget _buildReservationCard(BuildContext context, int x) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ReservationCard(
        titleColor: Theme.of(context).primaryColor,
        reservation: reservationsList[x],
      ),
    );
  }
}
