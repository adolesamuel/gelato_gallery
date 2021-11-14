import 'package:flutter/material.dart';

class GalleryLandingPage extends StatefulWidget {
  const GalleryLandingPage({Key? key}) : super(key: key);

  @override
  _GalleryLandingPageState createState() => _GalleryLandingPageState();
}

class _GalleryLandingPageState extends State<GalleryLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Page'),
      ),
    );
  }
}
