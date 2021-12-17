import 'package:flutter/material.dart';
import 'package:gallery_task/data/response/ApiResponse.dart';
import 'package:gallery_task/repository/FavPhotosSharedPrefRepo.dart';

class FavPhotosVM extends ChangeNotifier {
  final _myRepo = FavPhotosSharedPref();
  ApiResponse res = ApiResponse.loading();

  void _setFavPhoto(response) {
    res = response;
    notifyListeners();
  }

  Future<void> saveFavPhotosId(int id) async {
    _setFavPhoto(ApiResponse.loading());
    await _myRepo
        .saveFavPhotos(id)
        .then((value) => _setFavPhoto(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setFavPhoto(ApiResponse.error(error.toString())));
  }
}
