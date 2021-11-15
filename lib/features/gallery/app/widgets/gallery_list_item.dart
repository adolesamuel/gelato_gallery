import 'package:flutter/material.dart';
import 'package:gelato_gallery/features/gallery/app/pages/photo_detail_page.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';

class GalleryListItem extends StatefulWidget {
  final Photo photo;
  final Function()? onTap;
  const GalleryListItem({Key? key, required this.photo, this.onTap})
      : super(key: key);

  @override
  _GalleryListItemState createState() => _GalleryListItemState();
}

class _GalleryListItemState extends State<GalleryListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoDetailPage(photo: widget.photo),
            ));
      },
      child: Stack(
        children: [
          Image.network(
            widget.photo.imageUrl,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.photo.author,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
