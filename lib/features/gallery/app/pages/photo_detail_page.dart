import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/app/widgets/single_image_widget.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';

class PhotoDetailPage extends StatefulWidget {
  final int position;
  final List<Photo> photos;
  const PhotoDetailPage(
      {Key? key, required this.photos, required this.position})
      : super(key: key);

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  //the list and index are passed into the pageController
  //this is used for building and siding from on image to another
  late PageController _pageController;
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();
    photos = widget.photos;

    _pageController = PageController(initialPage: widget.position);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //uses a pagview allows swiping from picture to picture
    return Hero(
      tag: photos[widget.position].id,
      child: PageView.builder(
          itemCount: photos.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            return SingleImageWidget(photo: photos[index]);
          }),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //   ),
    //   body: Center(
    //     child: Image.network(
    //       widget.photo.photoDownloadUrl,
    //       // loadingBuilder: (context, child, imageChunk) {
    //       //   return CircularProgressIndicator(
    //       //     value: imageChunk!.expectedTotalBytes != null
    //       //         ? imageChunk.cumulativeBytesLoaded /
    //       //             imageChunk.expectedTotalBytes!.toDouble()
    //       //         : null,
    //       //   );
    //       // },
    //     ),
    //   ),
    // );
  }
}
