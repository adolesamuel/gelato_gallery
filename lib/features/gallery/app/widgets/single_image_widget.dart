import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/app/widgets/photo_info.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:photo_view/photo_view.dart';

//Show image in full screen
//with close, download and info bars
class SingleImageWidget extends StatefulWidget {
  ///Current photo
  final Photo photo;
  const SingleImageWidget({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  _SingleImageWidgetState createState() => _SingleImageWidgetState();
}

class _SingleImageWidgetState extends State<SingleImageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Image holding widget
          PhotoView(
              loadingBuilder: (context, imageChunk) {
                return imageChunk != null
                    ? Container(
                        color: Colors.black,
                        child: Center(
                            child: CircularProgressIndicator(
                          value: imageChunk.expectedTotalBytes == null
                              ? 0
                              : imageChunk.cumulativeBytesLoaded /
                                  imageChunk.expectedTotalBytes!.toInt(),
                        )),
                      )
                    : Container(
                        color: Colors.black,
                        child: Center(child: CircularProgressIndicator()));
              },
              imageProvider: NetworkImage(widget.photo.photoDownloadUrl)),
          //Close button
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                )),
          ),

          //Download Button and Info Button
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //download button
                IconButton(
                    onPressed: () async {
                      await ImageDownloader.downloadImage(
                              widget.photo.photoDownloadUrl)
                          .then((value) =>
                              showImageDownloaded(context, widget.photo));
                    },
                    icon: Icon(
                      Icons.download,
                      color: Colors.white,
                    )),

                //Info button
                IconButton(
                    onPressed: () {
                      showPhotoInfo(context, widget.photo);
                    },
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///shows the bottom sheet that has Photo Information
  void showPhotoInfo(BuildContext context, Photo photo) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (context) {
          return PhotoInfo(
            photo: photo,
          );
        });
  }

  //Helps download image
  void showImageDownloaded(BuildContext context, Photo photo) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
              height: 50.0,
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text('${photo.author} Image Downloaded!')));
        });
  }
}
