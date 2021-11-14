part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object> get props => [];
}

class FetchPhotosEvent extends GalleryEvent {
  final String page;
  final String limit;

  FetchPhotosEvent({this.page = '1', this.limit = '20'});
}
