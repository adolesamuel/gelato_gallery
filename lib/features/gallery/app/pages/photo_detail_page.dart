import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';

class PhotoDetailPage extends StatefulWidget {
  final Photo photo;
  const PhotoDetailPage({Key? key, required this.photo}) : super(key: key);

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Image.network(
          widget.photo.photoDownloadUrl,
          // loadingBuilder: (context, child, imageChunk) {
          //   return CircularProgressIndicator(
          //     value: imageChunk!.expectedTotalBytes != null
          //         ? imageChunk.cumulativeBytesLoaded /
          //             imageChunk.expectedTotalBytes!.toDouble()
          //         : null,
          //   );
          // },
        ),
      ),
    );
  }
}
