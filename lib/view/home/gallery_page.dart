import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_task/data/response/Status.dart';
import 'package:gallery_task/models/photos/PhotosModel.dart';
import 'package:gallery_task/repository/FavPhotosSharedPrefRepo.dart';
import 'package:gallery_task/res/dimentions/AppDimension.dart';
import 'package:gallery_task/view/widget/LoadingWidget.dart';
import 'package:gallery_task/view/widget/MyErrorWidget.dart';
import 'package:gallery_task/view/widget/MyTextView.dart';
import 'package:gallery_task/view/widget/ImageDialog.dart';
import 'package:gallery_task/view_model/FavPhotosVM.dart';
import 'package:gallery_task/view_model/PhotosVM.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final PhotosVM photosModel = PhotosVM();
  final FavPhotosSharedPref favPhotosSharedPref = FavPhotosSharedPref();
  final FavPhotosVM favPhotosVM = FavPhotosVM();

  @override
  void initState() {
    // favPhotosSharedPref.clear();
    photosModel.fetchPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      body: ChangeNotifierProvider<PhotosVM>(
        create: (BuildContext context) => photosModel,
        child: Consumer<PhotosVM>(builder: (context, photosModel, _) {
          switch (photosModel.photoMain.status) {
            case Status.LOADING:
              return LoadingWidget();
            case Status.ERROR:
              return MyErrorWidget(photosModel.photoMain.message ?? "NA");
            case Status.COMPLETED:
              return _getPhotosListView(photosModel.photoMain.data);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget _getPhotosListView(List<Photo> photosList) {
    return ListView.builder(
        itemCount: photosList?.length,
        itemBuilder: (context, position) {
          return _getPhotosListItem(photosList[position]);
        });
  }

  void fullImagePopup(String imageUrl) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ImageDialog(imageUrl: imageUrl);
        });
  }

  Widget _getPhotosListItem(Photo item) {
    return Card(
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            fullImagePopup(item.imageUrl);
          },
          child: ClipRRect(
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              width: AppDimension.of(context).listImageSize,
              height: AppDimension.of(context).listImageSize,
              imageUrl: item.thumbnailUrl ?? "",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            borderRadius: BorderRadius.circular(
                AppDimension.of(context).imageBorderRadius),
          ),
        ),
        title: MyTextView(item.title ?? "NA", Colors.blue,
            AppDimension.of(context).mediumText),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Icon(item.isFav ? Icons.favorite : Icons.favorite_border,
                  color: item.isFav ? Colors.red : null),
              onTap: () async {
                await favPhotosVM.saveFavPhotosId(item.id);
                if (item.isFav == true)
                  item.isFav = false;
                else {
                  item.isFav = true;
                }
                setState(() {});
              },
            ),
          ],
        ),
      ),
      elevation: AppDimension.of(context).lightElevation,
    );
  }
}
