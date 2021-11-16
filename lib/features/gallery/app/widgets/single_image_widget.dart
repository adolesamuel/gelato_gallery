import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';
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
                    ? Center(
                        child: CircularProgressIndicator(
                        value: imageChunk.expectedTotalBytes == null
                            ? 0
                            : imageChunk.cumulativeBytesLoaded /
                                imageChunk.expectedTotalBytes!.toInt(),
                      ))
                    : Center(child: CircularProgressIndicator());
              },
              imageProvider: NetworkImage(widget.photo.photoDownloadUrl)),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                  onPressed: () {},
                  //  () => requestDownload(
                  //     widget.photo.photoDownloadUrl,
                  //     widget.photo.author + widget.photo.id),
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
