import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paprica/generated/i18n.dart';

class MapScreen extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;
  final bool isSelecting;

  MapScreen({
    Key key,
    this.initialLatitude,
    this.initialLongitude,
    this.isSelecting,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;
  double latitude;
  double longitude;

  @override
  void initState() {
    if(widget.initialLatitude == null)
      latitude = 33.5;
    else{
      latitude = widget.initialLatitude;
    }
    if(widget.initialLongitude == null)
      longitude = 36.3;
    else{
      longitude = widget.initialLongitude;
    }
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
          widget.isSelecting == true ?
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            )
              :
              Container(height: 0.0, width: 0.0,),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            latitude,
            longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? null
            : <Marker>[
              Marker(
                  markerId: MarkerId('your location'),
                  position: _pickedLocation ??
                      LatLng(
                        latitude,
                        longitude,
                      ),
                ),
        ].toSet(),
        rotateGesturesEnabled: false,
      ),
    );
  }
}
