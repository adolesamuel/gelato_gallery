import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gelato_gallery/features/gallery/app/bloc/gallery_bloc.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';
import 'package:gelato_gallery/injection_container.dart';

class GalleryLandingPage extends StatefulWidget {
  const GalleryLandingPage({Key? key}) : super(key: key);

  @override
  _GalleryLandingPageState createState() => _GalleryLandingPageState();
}

class _GalleryLandingPageState extends State<GalleryLandingPage> {
  GalleryBloc galleryBloc = sl<GalleryBloc>();
  final _scrollController = ScrollController();
  List<Photo> photoList = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      galleryBloc..add(FetchPhotosEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Page'),
      ),
      body: BlocProvider<GalleryBloc>(
        create: (context) => galleryBloc..add(FetchPhotosEvent()),
        child: BlocConsumer<GalleryBloc, GalleryState>(
          listener: (context, state) {
            if (state is GalleryState) {
              photoList.addAll(state.photos);
            }
          },
          builder: (context, state) {
            return ListView.builder(
                addAutomaticKeepAlives: false,
                controller: _scrollController,
                itemCount: photoList.length,
                itemBuilder: (context, index) {
                  print(photoList.length);
                  return index >= photoList.length - 1
                      ? LinearProgressIndicator()
                      : ListTile(
                          title: Text(photoList[index].author),
                        );
                });
          },
        ),
      ),
    );
  }
}
