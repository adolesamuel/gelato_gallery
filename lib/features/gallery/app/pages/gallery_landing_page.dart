import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gelato_gallery/features/gallery/app/bloc/gallery_bloc.dart';
import 'package:gelato_gallery/injection_container.dart';

class GalleryLandingPage extends StatefulWidget {
  const GalleryLandingPage({Key? key}) : super(key: key);

  @override
  _GalleryLandingPageState createState() => _GalleryLandingPageState();
}

class _GalleryLandingPageState extends State<GalleryLandingPage> {
  GalleryBloc galleryBloc = sl<GalleryBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Page'),
      ),
      body: BlocProvider<GalleryBloc>(
        create: (context) => galleryBloc..add(FetchPhotosEvent()),
        child: BlocConsumer<GalleryBloc, GalleryState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GalleryState) {
              return ListView.builder(
                  itemCount: state.photos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.photos[index].author),
                    );
                  });
            } else {
              return Container(
                color: Colors.blue,
              );
            }
          },
        ),
      ),
    );
  }
}
