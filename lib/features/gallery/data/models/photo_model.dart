import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';

///Object object for photos
class PhotoModel extends Photo {
  ///Id of the photo
  @override
  final String id;

  ///Author of the photo
  @override
  final String author;

  ///width of the photo
  @override
  final int width;

  ///height of the photo
  @override
  final int height;

  ///url to fetch small version of photo from
  @override
  final String photoUrl;

  ///Url to download the photo to
  @override
  final String photoDownloadUrl;

  PhotoModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.photoUrl,
    required this.photoDownloadUrl,
  }) : super(
          id,
          author,
          width,
          height,
          photoUrl,
          photoDownloadUrl,
        );

  //Creates a photo object from a map
  factory PhotoModel.fromMap(Map map) {
    return PhotoModel(
      id: map['id'],
      author: map['author'],
      width: map['width'],
      height: map['height'],
      photoUrl: map['url'],
      photoDownloadUrl: map['download_url'],
    );
  }
}
