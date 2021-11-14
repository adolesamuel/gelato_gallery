import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gelato_gallery/features/gallery/domain/usecases/get_photos.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetPhotos getPhotos;

  GalleryBloc({required this.getPhotos}) : super(GalleryInitial()) {
    on<GalleryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
