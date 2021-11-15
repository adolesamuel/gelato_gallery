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

  ///url to fetch web page of author
  final String authorUrl;

  ///Url to download the photo to
  final String photoDownloadUrl;

  ///Small image url
  final String imageUrl;

  Photo(this.id, this.author, this.width, this.height, this.authorUrl,
      this.photoDownloadUrl, this.imageUrl);

  @override
  List<Object?> get props => [
        id,
        author,
        width,
        height,
        authorUrl,
        photoDownloadUrl,
        imageUrl,
      ];
}
