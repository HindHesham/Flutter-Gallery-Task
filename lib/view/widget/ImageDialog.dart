import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;
  ImageDialog({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl ?? "",
          placeholder: (context, url) => new Text('Loading......'),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
      ),
    );
  }
}
