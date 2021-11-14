part of 'gallery_bloc.dart';

class GalleryState extends Equatable {
  final int startIndex;
  final bool isFirstTime;
  final List<Photo> photos;
  final bool hasReachedMax;

  GalleryState({
    this.startIndex = 1,
    this.isFirstTime = true,
    this.photos = const <Photo>[],
    this.hasReachedMax = false,
  });

  GalleryState copyWith({
    int? startIndex,
    bool? isFirstTime,
    List<Photo>? photos,
    bool? hasReachedMax,
  }) {
    return GalleryState(
      startIndex: startIndex ?? this.startIndex,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        startIndex,
        isFirstTime,
        photos,
        hasReachedMax,
      ];
}

class GalleryInitial extends GalleryState {}

class FetchPhotosLoadingState extends GalleryState {}

class FetchPhotosErrorState extends GalleryState {
  final Failure failure;

  FetchPhotosErrorState(this.failure);
}
