import 'package:flutter/material.dart';
import 'package:gallery_task/data/response/ApiResponse.dart';
import 'package:gallery_task/models/photos/PhotosModel.dart';
import 'package:gallery_task/repository/PhotoRepo.dart';

class PhotosVM extends ChangeNotifier {
  final _myRepo = PhotoRepoImp();
  ApiResponse<List<Photo>> photoMain = ApiResponse.loading();

  void _setPhoto(ApiResponse<List<Photo>> response) {
    photoMain = response;
    notifyListeners();
  }

  Future<void> fetchPhotos() async {
    _setPhoto(ApiResponse.loading());
    await _myRepo
        .fetchPhotos()
        .then((value) => _setPhoto(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setPhoto(ApiResponse.error(error.toString())));
  }
}
