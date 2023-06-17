import 'dart:convert';

import 'package:favorite_places_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location? _pickedLocation;
  var _isGettingLocation = false;

  void _getCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final long = locationData.longitude;
    final API_URL = "$API_GOOGLE_GEO_URL?latlng=$lat,$long&key=$MAP_API_KEYS";
    final url = Uri.parse(API_URL);
    final response = await http.get(url);

    final Map<String,dynamic> resData = jsonDecode(response.body);
    final address = resData['results'][0]["formatted_address"];
    print(address);


    setState(() {
      _isGettingLocation = false;
    });

    print("lat / long ${locationData.latitude} / ${locationData.longitude}");
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: (!_isGettingLocation) ? Text(
            "No Location Chosen",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            )
          ) : const CircularProgressIndicator(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Get Current Location")
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_on),
              label: const Text("Select on Map")
            ),
          ],
        ),
      ],
    );
  }
}
