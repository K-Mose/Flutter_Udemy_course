import 'dart:io';

import 'package:favorite_places_app/model/place.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as p;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

final  placeProvider = StateNotifierProvider<_PlaceNotifier, List<Place>>(
        (ref) => _PlaceNotifier());

Future<Database> _getDatabase() async {
  // DB 생성 후 데이터 삽입
  final dbPath = await sql.getDatabasesPath();
  // option : https://pub.dev/documentation/sqflite_common/latest/sqflite/openDatabase.html
  final db = await sql.openDatabase(
    // db path
      p.join(dbPath, 'places.db'),
      // db가 생성될 때 실행할 함수
      // 기존에 디비가 존재하지 않을 때 실행됨
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE place("
                "id TEXT PRIMARY KEY, "
                "title TEXT, "
                "image TEXT,"
                "lat REAL,"
                "long REAL,"
                "address TEXT"
                ")"
        );
      },
      version: 1
  );
  return db;
}

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

    final db = await _getDatabase();

    db.insert("place", {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'lat': place.location.latitude,
      'long': place.location.longitude,
      'address': place.location.address
    });

    state = [place, ...state];
  }

  void removePlace(Place place) {
    state = [...state.where((p) => p != place)];
  }
}