import 'package:dartz/dartz.dart';
import 'package:gelato_gallery/core/failures/failure.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';

abstract class GalleryRepository {
  Future<Either<Failure, List<Photo>>> getPhotos(String page, String limit);
}
