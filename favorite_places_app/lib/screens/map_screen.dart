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
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    final location = widget.location;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.address),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save)
            )
        ],
      ),
      // google_maps_flutter 라이브러리
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 13
        ),
        markers: {
          Marker(
            markerId: const MarkerId('m1'),
            position: LatLng(location.latitude, location.longitude),
          ),
        },
      ),
    );
  }
}