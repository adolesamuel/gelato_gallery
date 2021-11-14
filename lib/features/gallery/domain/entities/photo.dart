import 'package:equatable/equatable.dart';

///Object entity for photos
class Photo extends Equatable {
  ///Id of the photo
  final String id;

  ///Author of the photo
  final String author;

  ///width of the photo
  final int width;

  ///height of the photo
  final int height;

  ///url to fetch small version of photo from
  final String photoUrl;

  ///Url to download the photo to
  final String photoDownloadUrl;

  Photo(
    this.id,
    this.author,
    this.width,
    this.height,
    this.photoUrl,
    this.photoDownloadUrl,
  );

  @override
  List<Object?> get props => [
        id,
        author,
        width,
        height,
        photoUrl,
        photoDownloadUrl,
      ];
}
