import 'package:favorite_places_app/model/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  static const routeName = "/mapScreen";
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.56291,
      longitude: 126.98249,
      address: "Seoul"
    ),
    this.isSelecting = true,
    this.isSelected = false,
  });

  final PlaceLocation location;
  final bool isSelecting;
  final bool isSelected;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    final location = widget.location;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting
                  ? "Pick Your Location"
                  : "Your Location"
                ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save)
            )
        ],
      ),
      // google_maps_flutter 라이브러리
      body: GoogleMap(
        onTap: !widget.isSelecting ? null : (position) {
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 13
        ),
        markers: (
                  _pickedLocation == null
                      && widget.isSelecting
                      && !widget.isSelected
                ) ? {} : {
          Marker(
            markerId: const MarkerId('m1'),
            position: _pickedLocation
                ?? LatLng(location.latitude, location.longitude),
          ),
        },
      ),
    );
  }
}