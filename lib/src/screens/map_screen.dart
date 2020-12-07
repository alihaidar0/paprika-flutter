import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paprica/generated/i18n.dart';

class MapScreen extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;
  final double resLatitude;
  final double resLongitude;
  final bool isSelecting;

  MapScreen({
    Key key,
    this.initialLatitude,
    this.initialLongitude,
    this.resLatitude,
    this.resLongitude,
    this.isSelecting,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  @override
  void initState() {
    _pickedLocation = null;
    super.initState();
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).clickToLocateYou),
        actions: <Widget>[
          _pickedLocation != null
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                          Navigator.of(context).pop(_pickedLocation);
                        },
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.resLatitude,
            widget.resLongitude,
          ),
          zoom: 16,
        ),
        onTap: _selectLocation,
        markers: (_pickedLocation == null && !widget.isSelecting)
            ? <Marker>[
                Marker(
                  markerId: MarkerId('restaurant location'),
                  infoWindow: InfoWindow(title: "restaurant location"),
                  position: LatLng(
                    widget.resLatitude,
                    widget.resLongitude,
                  ),
                ),
              ].toSet()
            : <Marker>[
                Marker(
                  markerId: MarkerId('restaurant location'),
                  infoWindow: InfoWindow(title: "restaurant location"),
                  position: LatLng(
                    widget.resLatitude,
                    widget.resLongitude,
                  ),
                ),
                Marker(
                  markerId: MarkerId('your location'),
                  infoWindow: InfoWindow(title: "your location"),
                  position: _pickedLocation ??
                      LatLng(
                        widget.initialLatitude,
                        widget.initialLongitude,
                      ),
                ),
              ].toSet(),
        rotateGesturesEnabled: false,
      ),
    );
  }
}
