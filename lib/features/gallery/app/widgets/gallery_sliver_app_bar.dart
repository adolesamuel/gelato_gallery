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

    AlertDialog alert = AlertDialog(
        clipBehavior: Clip.antiAlias,
        title: Text("Pixel8 for Gelato"),
        content: Container(
          height: 120,
          width: 150,
          child: Column(
            children: const [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/sam.jpg'),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                'Built by Adole Samuel',
              ),
            ],
          ),
        ));

    return SliverAppBar(
        pinned: true,
        snap: false,
        floating: true,
        forceElevated: true,
        expandedHeight: size.height * 0.3,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                )),
          ),
        ],
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
