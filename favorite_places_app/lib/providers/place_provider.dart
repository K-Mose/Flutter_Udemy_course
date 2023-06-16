import 'package:favorite_places_app/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final  placeProvider = StateNotifierProvider<_PlaceNotifier, List<Place>>(
        (ref) => _PlaceNotifier());

class _PlaceNotifier extends StateNotifier<List<Place>> {
  _PlaceNotifier() : super([]);

  void addPlace(Place place) {
    state = [...state, place];
  }
}