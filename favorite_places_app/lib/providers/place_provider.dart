import 'dart:io';

import 'package:favorite_places_app/model/place.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as p;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final  placeProvider = StateNotifierProvider<_PlaceNotifier, List<Place>>(
        (ref) => _PlaceNotifier());

class _PlaceNotifier extends StateNotifier<List<Place>> {
  _PlaceNotifier() : super([]);

  void addPlace(String title, File image, PlaceLocation location) async {
    // 앱에 따라서 경로가 다르기 때문에 경로를 다르게 가져옴
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // image_picker에서 임시로 저장한 파일을 복사하여
    // 캐시 폴더에서 앱 디렉터리 폴더로 복사
    final filename = p.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');


    final place = Place(
        title: title,
        image: copiedImage,
        location: location
    );
    state = [place, ...state];
  }

  void removePlace(Place place) {
    state = [...state.where((p) => p != place)];
  }
}