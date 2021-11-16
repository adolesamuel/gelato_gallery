import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/app/widgets/photo_info.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';
import 'package:image_downloader/image_downloader.dart';
// import 'package:gelato_gallery/features/image_download/image_downloader.dart';
import 'package:photo_view/photo_view.dart';

class SingleImageWidget extends StatefulWidget {
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
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
