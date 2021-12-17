import 'package:gallery_task/data/network/ApiEndPoints.dart';
import 'package:gallery_task/data/network/BaseApiService.dart';
import 'package:gallery_task/data/network/NetworkApiService.dart';
import 'package:gallery_task/models/photos/PhotosModel.dart';

import 'FavPhotosSharedPrefRepo.dart';

class PhotoRepoImp {
  BaseApiService _apiService = NetworkApiService();

  Future<List<Photo>> fetchPhotos() async {
    FavPhotosSharedPref favPhotosSharedPref = new FavPhotosSharedPref();

    final photosId = await favPhotosSharedPref.getFavPhotos('favPhotosListId');
    final response = await _apiService.getResponse(ApiEndPoints().getPhotos);

    final res =
        response.map<Photo>((json) => Photo.fromJson(json, photosId)).toList();
    return res;
  }
}
