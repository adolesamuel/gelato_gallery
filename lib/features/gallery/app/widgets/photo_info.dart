import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';

class PhotoInfo extends StatelessWidget {
  final Photo photo;
  const PhotoInfo({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
    );
    return Container(
      height: 100.0,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Author: ${photo.author}',
            style: style,
          ),
          Text(
            'Dimensions: ${photo.width} X ${photo.height}',
            style: style,
          ),
        ],
      ),
    );
  }
}
