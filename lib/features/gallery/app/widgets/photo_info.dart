import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';

///Show available Photo Information
class PhotoInfo extends StatelessWidget {
  ///uses a photo
  final Photo photo;
  const PhotoInfo({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 16,
    );
    TextStyle styleCaption =
        TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
    return Container(
      height: 100.0,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Author: ',
                style: styleCaption,
              ),
              Text(
                ' ${photo.author}',
                style: style,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Dimensions: ',
                style: styleCaption,
              ),
              Text(
                '${photo.width} X ${photo.height}',
                style: style,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
