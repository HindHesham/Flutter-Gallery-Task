import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavPhotosSharedPref {
  //save data in shared preferences
  Future<void> saveFavPhotos(int favPhotosId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favPhotosListId = await getFavPhotos('favPhotosListId');
    if (favPhotosListId.contains(favPhotosId)) {
      favPhotosListId.remove(favPhotosId);
    } else
      favPhotosListId.add(favPhotosId);
    await prefs.setString('favPhotosListId', json.encode(favPhotosListId));
  }

  Future getFavPhotos(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final photoJson = prefs.getString(key);
    if (photoJson != null) {
      return json.decode(photoJson);
    } else
      return [];
  }

  Future clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
