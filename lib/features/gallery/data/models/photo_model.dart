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
  final String authorUrl;

  ///Url to download the photo to
  @override
  final String photoDownloadUrl;

  @override
  final String imageUrl;

  PhotoModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.authorUrl,
    required this.photoDownloadUrl,
    required this.imageUrl,
  }) : super(
          id,
          author,
          width,
          height,
          authorUrl,
          photoDownloadUrl,
          imageUrl,
        );

  //Creates a photo object from a map
  factory PhotoModel.fromMap(Map map) {
    return PhotoModel(
      id: map['id'],
      author: map['author'],
      width: map['width'],
      height: map['height'],
      authorUrl: map['url'],
      photoDownloadUrl: map['download_url'],
      imageUrl: _getSmallImageUrl(map),
    );
  }

  ///Create a small image url from the download_url
  static String _getSmallImageUrl(Map map) {
    String url = map['download_url'];

    // sample download_url is 'https://picsum.photos/id/1000/5626/3635';
    //and from api docs, appending sizes to images helps reduce the image size
    //the last lines 8 digit represents the sizes
    //so I strip the first part less the width and height
    //and attach the (image height and width both divided by 10)

    int scaleFactor = 6;

    double height = (map['height'] / scaleFactor);

    double width = (map['width'] / scaleFactor);

    //just strips everything till picture id
    final regex = RegExp(r'^([a-z]+\:\/\/[a-z]+\.[a-z]+\/[a-z]+\/[0-9]+\/)');

    //this won't return a match if the download_url format changes
    final match = regex.stringMatch(url);

    final imageUrl =
        match! + width.toInt().toString() + '/' + height.toInt().toString();

    return imageUrl;
  }
}
