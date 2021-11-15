import 'package:flutter/material.dart';

class GallerySliverAppBar extends StatefulWidget {
  const GallerySliverAppBar({Key? key}) : super(key: key);

  @override
  _GallerySliverAppBarState createState() => _GallerySliverAppBarState();
}

class _GallerySliverAppBarState extends State<GallerySliverAppBar> {
  //asset image

  String bgAssetString = 'assets/bg.jpg';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SliverAppBar(
        pinned: true,
        snap: false,
        floating: true,
        forceElevated: true,
        expandedHeight: size.height * 0.3,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          titlePadding: EdgeInsets.all(16.0),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'Pixel8',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                ' for Gelato',
                style: TextStyle(color: Colors.white, fontSize: 10),
              )
            ],
          ),
          background: Image.asset(
            bgAssetString,
            fit: BoxFit.cover,
          ),
        ));
  }
}
