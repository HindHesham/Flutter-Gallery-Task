class Photo {
  Photo(
      {this.id,
      this.albumId,
      this.title,
      this.imageUrl,
      this.thumbnailUrl,
      this.isFav = false});

  int id;
  int albumId;
  String title;
  String imageUrl;
  String thumbnailUrl;
  bool isFav;

  factory Photo.fromJson(Map<String, dynamic> json, List favPhotosList) =>
      Photo(
        id: json["id"] == null ? null : json["id"],
        albumId: json["albumId"] == null ? null : json["albumId"],
        title: json["title"] == null ? null : json["title"],
        imageUrl: json["url"] == null ? null : json["url"],
        thumbnailUrl:
            json["thumbnailUrl"] == null ? null : json["thumbnailUrl"],
        isFav: favPhotosList.contains(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "albumId": id == null ? null : albumId,
        "title": title == null ? null : title,
        "url": imageUrl == null ? null : imageUrl,
        "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,
        "isFav": isFav == null ? null : isFav,
      };
}
