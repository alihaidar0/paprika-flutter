import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paprika/generated/i18n.dart';
import 'package:paprika/src/models/event_model.dart';
import 'package:paprika/src/screens/events_list_screen.dart';
import 'package:paprika/src/utils/map_utils.dart';
import 'package:paprika/src/widgets/event_card.dart';
import 'package:paprika/src/widgets/images_gallery.dart';
import 'package:paprika/src/widgets/restaurant_infoRow.dart';
import 'package:paprika/utils.dart';
import 'package:paprika/widgets.dart';
import 'package:swagger/api.dart';

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
                  S
                      .of(context)
                      .comingEvent,
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
                        builder: (context) =>
                            EventsListScreen(
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
                        (S
                            .of(context)
                            .viewMoreEvents).toUpperCase(),
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

class InformationSection extends StatefulWidget {
  final RestaurantHomeDto restData;

  const InformationSection(this.restData);

  @override
  _InformationSectionState createState() => _InformationSectionState();
}

class _InformationSectionState extends State<InformationSection> {
  bool showWorkingTimes;

  @override
  void initState() {
    super.initState();
    showWorkingTimes = false;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawables = getDrawableInformation(context);
    return Container(
      color: Color(0xFFf2f2f2),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Center(
                child: drawables.length > 0
                    ? Wrap(
                  spacing: 24,
                  children: drawables,
                )
                    : Container(),
              ),
            ),

            /// Opening Time ///
            (widget.restData.is24Hour != null && widget.restData.is24Hour) ||
                (widget.restData.openingTimes == null ||
                    widget.restData.openingTimes.length == 0)
                ? Container()
                : Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 15.0),
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image(
                            image:
                            AssetImage("assets/icons/open_time.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, top: 4.0, right: 5.0),
                          child: Text(
                            S
                                .of(context)
                                .workingHours,
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showWorkingTimes
                      ? Column(
                    children: List.generate(
                      widget.restData.openingTimes.length,
                          (index) =>
                          Container(
                            color: (index % 2 != 0)
                                ? Colors.white
                                : Color(0xFFE1E1E1),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  top: 5.0,
                                  right: 8.0,
                                  bottom: 5.0),
                              child: Table(
                                children: [
                                  TableRow(children: [
                                    Text(
                                      ApiHelper.toStringDayOfWeek(
                                          context,
                                          widget
                                              .restData
                                              .openingTimes[index]
                                              .dayOfWeek),
                                    ),
                                    Text(
                                      PaprikaFormatter.formatTimeOnly(
                                          context,
                                          widget
                                              .restData
                                              .openingTimes[index]
                                              .fromTime),
                                    ),
                                    Text(
                                      PaprikaFormatter.formatTimeOnly(
                                        context,
                                        widget.restData
                                            .openingTimes[index].toTime,
                                      ),
                                    )
                                  ]),
                                ],
                              ),
                            ),
                          ),
                    ),
                  )
                      : Container(
                    padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 5.0,
                        right: 8.0,
                        bottom: 5.0),
                    color: Color(0xFFE1E1E1),
                    child: Table(
                      children: [
                        TableRow(children: [
                          Text(
                            ApiHelper.toStringDayOfWeek(
                                context,
                                widget.restData.openingTimes[0]
                                    .dayOfWeek),
                          ),
                          Text(
                            PaprikaFormatter.formatTimeOnly(
                                context,
                                widget.restData.openingTimes[0]
                                    .fromTime),
                          ),
                          Text(
                            PaprikaFormatter.formatTimeOnly(
                              context,
                              widget
                                  .restData.openingTimes[0].toTime,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: showWorkingTimes
                        ? Icon(
                      CupertinoIcons.chevron_up_circle,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      size: 28.0,
                    )
                        : Icon(
                      CupertinoIcons.chevron_down_circle,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      size: 28.0,
                    ),
                    onPressed: () {
                      setState(() {
                        showWorkingTimes = !showWorkingTimes;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _actionCallRestaurant(BuildContext context, String number) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CallRestaurantDialog(
          phoneNumber: number,
          restaurantName: widget.restData.name,
        );
      },
    );
  }

  List<Widget> getDrawableInformation(BuildContext context) {
    List<Widget> drawables = List();
    if (widget.restData.restaurantTypes != null && widget.restData.restaurantTypes != 0) {
      drawables.add(
        WideInfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              widget.restData.restaurantTypes, Type.places,
              maxNumber: 5, separator: S
              .of(context)
              .comma + ' '),
          icon: AssetImage('assets/icons/restaurant_type.png'),
        ),
      );
    }
    if (widget.restData.phoneNumber != null) {
      drawables.add(
        InkWell(
          onTap: () =>
              _actionCallRestaurant(context, widget.restData.phoneNumber),
          child: InfoRow(
            title: widget.restData.phoneNumber,
            icon: AssetImage('assets/icons/phone.png'),
            textDirection: TextDirection.ltr,
          ),
        ),
      );
    }
    if (widget.restData.tel != null) {
      drawables.add(
        InkWell(
          onTap: () => _actionCallRestaurant(context, widget.restData.tel),
          child: InfoRow(
            title: widget.restData.tel,
            icon: AssetImage('assets/icons/telephone.png'),
            textDirection: TextDirection.ltr,
          ),
        ),
      );
    }
    if (widget.restData.is24Hour != null && widget.restData.is24Hour) {
      drawables.add(
        InfoRow(
          title: '24/7',
          icon: AssetImage('assets/icons/open_time.png'),
        ),
      );
    }
    if (widget.restData.cuisineTypes != null &&
        widget.restData.cuisineTypes != 0) {
      drawables.add(
        InfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              widget.restData.cuisineTypes, Type.cuisines,
              maxNumber: 2, separator: S
              .of(context)
              .comma + ' '),
          icon: AssetImage('assets/icons/cuisine.png'),
        ),
      );
    }
    if (widget.restData.musicTypes != null && widget.restData.musicTypes != 0) {
      drawables.add(
        InfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              widget.restData.musicTypes, Type.music,
              maxNumber: 2, separator: S
              .of(context)
              .comma + ' '),
          icon: AssetImage('assets/icons/music.png'),
        ),
      );
    }
    if (widget.restData.parkingTypes != null &&
        widget.restData.parkingTypes != 0) {
      drawables.add(
        InfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              widget.restData.parkingTypes, Type.parking,
              maxNumber: 2, separator: S
              .of(context)
              .comma + ' '),
          icon: AssetImage('assets/icons/parking.png'),
        ),
      );
    }
    if (widget.restData.ambianceTypes != null &&
        widget.restData.ambianceTypes != 0) {
      drawables.add(
        InfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              widget.restData.ambianceTypes, Type.ambiance,
              maxNumber: 2, separator: S
              .of(context)
              .comma + ' '),
          icon: AssetImage('assets/icons/ambiance.png'),
        ),
      );
    }
    if (widget.restData.amenityTypes != null &&
        widget.restData.amenityTypes != 0) {
      drawables.add(
        InfoRow(
          title: ApiTypesHelper().getCommaSeparatedTypeNamesByValue(
              widget.restData.amenityTypes, Type.amenities,
              maxNumber: 2, separator: S
              .of(context)
              .comma + ' '),
          icon: AssetImage('assets/icons/amenities.png'),
        ),
      );
    }
    if (widget.restData.isSmokeFree != null) {
      drawables.add(
        InfoRow(
          title: this.widget.restData.isSmokeFree != null &&
              this.widget.restData.isSmokeFree
              ? S
              .of(context)
              .smokeFree
              : S
              .of(context)
              .noSmoking,
          icon: AssetImage('assets/icons/smoking.png'),
        ),
      );
    }
    if (widget.restData.hasShisha != null) {
      drawables.add(
        InfoRow(
          title: this.widget.restData.hasShisha != null &&
              this.widget.restData.hasShisha
              ? S
              .of(context)
              .hssShisha
              : S
              .of(context)
              .noShisha,
          icon: AssetImage('assets/icons/shisha.png'),
        ),
      );
    }
    if (widget.restData.isAlcoholFree != null) {
      drawables.add(
        InfoRow(
          title: this.widget.restData.isAlcoholFree != null &&
              this.widget.restData.isAlcoholFree
              ? S
              .of(context)
              .alcoholFree
              : S
              .of(context)
              .noAlcohol,
          icon: AssetImage('assets/icons/alcohol.png'),
        ),
      );
    }
    return drawables;
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
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    Text(
                      S
                          .of(context)
                          .address,
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor,
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
