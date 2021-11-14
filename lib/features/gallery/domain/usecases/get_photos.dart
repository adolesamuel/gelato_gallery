import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gelato_gallery/core/failures/failure.dart';
import 'package:gelato_gallery/core/usecase/usecase.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';
import 'package:gelato_gallery/features/gallery/domain/repository/gallery_repository.dart';

class GetPhotos extends Usecase<List<Photo>, GetPhotosParams> {
  final GalleryRepository galleryRepository;

  GetPhotos(this.galleryRepository);

  @override
  Future<Either<Failure, List<Photo>>> call(GetPhotosParams params) {
    return galleryRepository.getPhotos(params.page, params.limit);
  }
}

class GetPhotosParams extends Equatable {
  ///Page number
  final String page;

  ///Number of items to return
  final String limit;

  GetPhotosParams(this.page, this.limit);

  @override
  List<Object?> get props => [
        page,
        limit,
      ];
}
