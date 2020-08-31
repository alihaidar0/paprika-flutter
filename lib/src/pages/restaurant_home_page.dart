import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/src/models/event_model.dart';
import 'package:paprica/src/screens/events_list_screen.dart';
import 'package:paprica/src/utils/map_utils.dart';
import 'package:paprica/src/widgets/event_card.dart';
import 'package:paprica/src/widgets/images_gallery.dart';
import 'package:paprica/src/widgets/restaurant_infoRow.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';
import 'package:paprica/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantHomePage extends StatefulWidget {
  final RestaurantHomeDto restData;

  RestaurantHomePage(this.restData);

  @override
  _RestaurantHomePageState createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<RestaurantHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowScrollBehaviour(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _checkUpcomingEvents(context),
            widget.restData != null &&
                    widget.restData.galleryItems != null &&
                    widget.restData.galleryItems.length > 0
                ? Container(
                    color: Color(0xFFf2f2f2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ImagesGallery(
                        thumbnails:
                            extractThumbnailList(widget.restData.galleryItems),
                        urls: extractGalleryList(widget.restData.galleryItems),
                      ),
                    ),
                  )
                : Container(),
            ReviewResult(
              restaurantRate: widget.restData.restaurantRate,
              restaurantRaters: widget.restData.restaurantRaters,
              backgroundColor: Colors.white,
            ),
            ServiceReviewsLine(
              foodRate: widget.restData.foodRate,
              serviceRate: widget.restData.serviceRate,
              shishaRate: widget.restData.shishaRate,
              ambianceRate: widget.restData.ambianceRate,
              noiseLevel: ApiHelper.toStringNoiseLevel(
                  context, widget.restData.noiseLevel),
              backgroundColor: Colors.white,
            ),
            InformationSection(widget.restData),
            MapSection(
                address: widget.restData.address,
                markers: (widget.restData.latitude != null &&
                        widget.restData.longitude != null)
                    ? <Marker>[
                        Marker(
                            markerId: MarkerId(widget.restData.name),
                            infoWindow: InfoWindow(title: widget.restData.name),
                            position: LatLng(widget.restData.latitude,
                                widget.restData.longitude))
                      ].toSet()
                    : null),
            SizedBox(height: 60)
          ],
        ),
      ),
    );
  }

  _checkUpcomingEvents(BuildContext context) {
    if (widget.restData.event != null) {
      return Container(
        color: Color(0xfff2f2f2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  S.of(context).comingEvent,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            EventCard(
              event: EventModel.fromRestaurantEventDto(widget.restData.event),
              margin: EdgeInsets.all(0),
              borderRadius: 0,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventsListScreen(
                              restaurantId: widget.restData.id,
                              restaurantName: widget.restData.name,
                            )));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        (S.of(context).viewMoreEvents).toUpperCase(),
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return EmptyWidget();
    }
  }
}

class InformationSection extends StatelessWidget {
  final RestaurantHomeDto restData;

  const InformationSection(this.restData);

  @override
  Widget build(BuildContext context) {
    List<Widget> drawables = getDrawableInformation(context);
    return Container(
      color: Color(0xFFf2f2f2),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Don't draw the row if none of the following information is provided
            Row(
              children: <Widget>[
                Flexible(
                  child: drawables.length > 0
                      ? Wrap(
                          spacing: 24,
                          children: drawables,
                        )
                      : Container(),
                ),
              ],
            ),

            /// Opening Time ///
            (restData.is24Hour != null && restData.is24Hour) ||
                    (restData.openingTimes == null ||
                        restData.openingTimes.length == 0)
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              Localizations.localeOf(context).languageCode ==
                                      'en'
                                  ? const EdgeInsets.fromLTRB(0, 8, 8, 8)
                                  : const EdgeInsets.fromLTRB(8, 8, 0, 8),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image(
                              image: AssetImage("assets/icons/open_time.png"),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Table(
                                    columnWidths: {
                                      0: FlexColumnWidth(3),
                                      1: FlexColumnWidth(7)
                                    },
                                    children: restData.openingTimes
                                        .map<TableRow>((ot) {
                                      return TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 4),
                                          child: Text(
                                            ApiHelper.toStringDayOfWeek(
                                                context, ot.dayOfWeek),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                        Text(PapricaFormatter.formatTimeOnly(
                                                context, ot.fromTime) +
                                            (Localizations.localeOf(context)
                                                        .languageCode ==
                                                    'en'
                                                ? " → "
                                                : " ← ") +
                                            PapricaFormatter.formatTimeOnly(
                                              context,
                                              ot.toTime,
                                            ))
                                      ]);
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  List<Widget> getDrawableInformation(BuildContext context) {
    List<Widget> drawables = List();
    if (restData.phoneNumber != null) {
      drawables.add(
        InfoRow(
          title: restData.phoneNumber,
          icon: AssetImage('assets/icons/phone.png'),
          textDirection: TextDirection.ltr,
        ),
      );
    }
    if (restData.is24Hour != null && restData.is24Hour) {
      drawables.add(
        InfoRow(
          title: '24/7',
          icon: AssetImage('assets/icons/open_time.png'),
        ),
      );
    }
    if (restData.cuisineTypes != null && restData.cuisineTypes != 0) {
      drawables.add(
        InfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              restData.cuisineTypes, Type.cuisines,
              maxNumber: 2, separator: S.of(context).comma + ' '),
          icon: AssetImage('assets/icons/cuisine.png'),
        ),
      );
    }
    if (restData.musicTypes != null && restData.musicTypes != 0) {
      drawables.add(
        InfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              restData.musicTypes, Type.music,
              maxNumber: 2, separator: S.of(context).comma + ' '),
          icon: AssetImage('assets/icons/music.png'),
        ),
      );
    }
    if (restData.parkingTypes != null && restData.parkingTypes != 0) {
      drawables.add(
        InfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              restData.parkingTypes, Type.parking,
              maxNumber: 2, separator: S.of(context).comma + ' '),
          icon: AssetImage('assets/icons/parking.png'),
        ),
      );
    }
    if (restData.ambianceTypes != null && restData.ambianceTypes != 0) {
      drawables.add(
        InfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              restData.ambianceTypes, Type.ambiance,
              maxNumber: 2, separator: S.of(context).comma + ' '),
          icon: AssetImage('assets/icons/ambiance.png'),
        ),
      );
    }
    if (restData.amenityTypes != null && restData.amenityTypes != 0) {
      drawables.add(
        InfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              restData.amenityTypes, Type.amenities,
              maxNumber: 2, separator: S.of(context).comma + ' '),
          icon: AssetImage('assets/icons/amenities.png'),
        ),
      );
    }
    if (restData.isSmokeFree != null && restData.isSmokeFree) {
      drawables.add(
        InfoRow(
          title: this.restData.isSmokeFree != null && this.restData.isSmokeFree
              ? S.of(context).smokeFree
              : S.of(context).noSmoking,
          icon: AssetImage('assets/icons/smoking.png'),
        ),
      );
    }

    if (restData.isAlcoholFree != null && restData.isAlcoholFree) {
      drawables.add(
        InfoRow(
          title:
              this.restData.isAlcoholFree != null && this.restData.isAlcoholFree
                  ? S.of(context).alcoholFree
                  : S.of(context).noAlcohol,
          icon: AssetImage('assets/icons/alcohol.png'),
        ),
      );
    }
    return drawables;
  }

  String _getOpeningTimes(
      BuildContext context, List<OpeningTimeDto> openingTimes) {
    String openingTime = "";
    for (OpeningTimeDto ot in openingTimes) {
      openingTime += ApiHelper.toStringDayOfWeek(context, ot.dayOfWeek) +
          ": " +
          PapricaFormatter.formatTimeOnly(context, ot.fromTime) +
          " → " +
          PapricaFormatter.formatTimeOnly(context, ot.toTime) +
          "\n";
    }
    return openingTime;
  }
}

class MapSection extends StatefulWidget {
  final Set<Marker> markers;

  final String address;

  MapSection({this.address, this.markers});

  @override
  _MapSectionState createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: _resetMapCamera,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 36,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      S.of(context).address,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        widget.address,
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              height: 160,
              child: GoogleMap(
                onTap: (latLog) {
                  MapUtils.openMap(
                    latitude: widget.markers.toList()[0].position.latitude,
                    longitude: widget.markers.toList()[0].position.longitude,
                  );
                },
                onMapCreated: _onMapCreated,
                markers: widget.markers,
                initialCameraPosition: CameraPosition(
                  target: widget.markers?.toList()[0]?.position,
                  zoom: 11.0,
                ),
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: false,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _resetMapCamera() {
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: widget.markers?.toList()[0]?.position, zoom: 11.0),
      ));
    }
  }
}

List<String> extractThumbnailList(List<GalleryItemDto> data) {
  List<String> thumbnails = List<String>();
  for (GalleryItemDto item in data) {
    thumbnails.add(item.thumbnailImage);
  }
  return thumbnails;
}

List<String> extractGalleryList(List<GalleryItemDto> data) {
  List<String> images = List<String>();
  for (GalleryItemDto item in data) {
    images.add(item.image);
  }
  return images;
}
