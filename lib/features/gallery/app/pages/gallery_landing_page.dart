import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gelato_gallery/features/common/scroll_behavior.dart';
import 'package:gelato_gallery/features/gallery/app/bloc/gallery_bloc.dart';
import 'package:gelato_gallery/features/gallery/app/pages/photo_detail_page.dart';
import 'package:gelato_gallery/features/gallery/app/widgets/gallery_list_item.dart';
import 'package:gelato_gallery/features/gallery/app/widgets/gallery_sliver_app_bar.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';
import 'package:gelato_gallery/injection_container.dart';

class GalleryLandingPage extends StatefulWidget {
  const GalleryLandingPage({Key? key}) : super(key: key);

  @override
  _GalleryLandingPageState createState() => _GalleryLandingPageState();
}

class _GalleryLandingPageState extends State<GalleryLandingPage> {
  //Gallery Bloc
  GalleryBloc galleryBloc = sl<GalleryBloc>();

  //Scroll controller for all the list
  final _scrollController = ScrollController();

  //Photos list that gets populated
  List<Photo> photoList = [];

  //I was changing the start index
  //so it doesn't always load same set everytime
  //But has been disabled to ensure consistency of images
  //so my app can be better evaluated
  //
  //getting a random int between the min and max index
  //of the backgroundStringAssetList
  // int get randomIndex => Random().nextInt(10);
  int startIndex = 1;

  @override
  void initState() {
    super.initState();
    // startIndex = randomIndex;
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
      //if at bottom increase start index and fetch more photos
      startIndex += 1;
      galleryBloc.add(FetchPhotosEvent(page: (startIndex).toString()));
    }
  }

  bool get _isBottom {
    //Detect when the current scroll position is at the
    //maximum extent present. i.e scrolled to bottom of page
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            //Make request immediately page loads
            galleryBloc..add(FetchPhotosEvent(page: startIndex.toString())),
        child: BlocConsumer<GalleryBloc, GalleryState>(
          listener: (context, state) {
            //when images are successfully returned
            if (state is GalleryState) {
              photoList.addAll(state.photos);
            }
          },
          builder: (context, state) {
            return SafeArea(
              top: false, //guard agains covering home buttons
              child: Scaffold(
                body: Container(
                  color: Colors.black,
                  child: Scrollbar(
                    controller: _scrollController,
                    isAlwaysShown: true,
                    interactive: true,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(), //Custom scroll indicator
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          //My Beautiful AppBar
                          GallerySliverAppBar(),

                          //List of scrolling images
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) => Hero(
                                      tag: photoList[index]
                                          .id, //using hero to animate between pages
                                      child: GalleryListItem(
                                        photo: photoList[index],
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Hero(
                                                  tag: photoList[index].id,
                                                  child: PhotoDetailPage(
                                                      position: index,
                                                      photos: photoList),
                                                ),
                                              ));
                                        },
                                      ),
                                    ),
                                childCount: photoList.length),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
