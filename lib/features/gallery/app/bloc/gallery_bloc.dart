import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gelato_gallery/core/failures/failure.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';
import 'package:gelato_gallery/features/gallery/domain/usecases/get_photos.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetPhotos getPhotos;

  GalleryBloc({required this.getPhotos}) : super(GalleryInitial()) {
    // on<GalleryEvent>(_mapGalleryEventToState);
    on<FetchPhotosEvent>(_fetchPhotos);
  }

  Future<void> _fetchPhotos(
      FetchPhotosEvent event, Emitter<GalleryState> emit) async {
    //if max extent of list has been updated as true by state
    if (state.hasReachedMax) {
      return;
    } else if (state.isFirstTime) {
      //first time requesting infinite list
      emit(FetchPhotosLoadingState());

      final getPhotosOrFailure =
          await getPhotos(GetPhotosParams(event.page, event.limit));

      emit(getPhotosOrFailure.fold((failure) => FetchPhotosErrorState(failure),
          (photos) {
        return state.copyWith(
          isFirstTime: false,
          photos: photos,
          hasReachedMax: false,
        );
      }));
    } else {
      emit(FetchPhotosLoadingState());
      //increase the page integer here
      final getPhotosOrFailure =
          await getPhotos(GetPhotosParams(event.page, event.limit));

      emit(getPhotosOrFailure.fold((failure) => FetchPhotosErrorState(failure),
          (photos) {
        //if photos is Empty, return hasReachedMax state else
        //return state with photos added to previous
        return photos.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                startIndex: state.startIndex + 1,
                isFirstTime: false,
                photos: photos,
                // photos: List.of(state.photos)..addAll(photos),
                hasReachedMax: false,
              );
      }));
    }
  }
}
