import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/app/widgets/single_image_widget.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';

///Show Images in full screen
///support swipe left and right
class PhotoDetailPage extends StatefulWidget {
  ///Current index of photos
  final int position;

  ///Current list of photos
  final List<Photo> photos;
  const PhotoDetailPage(
      {Key? key, required this.photos, required this.position})
      : super(key: key);

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  //the list and index are passed into the pageController
  //this is used for building and siding from one image to another
  late PageController _pageController;

  //Photos instantiated when loadinng detail page
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
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
            itemCount: photos.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              //To better prettify the image holder
              return SingleImageWidget(photo: photos[index]);
            }),
      ),
    );
  }
}
