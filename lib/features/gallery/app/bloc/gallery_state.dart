part of 'gallery_bloc.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();
  
  @override
  List<Object> get props => [];
}

class GalleryInitial extends GalleryState {}
