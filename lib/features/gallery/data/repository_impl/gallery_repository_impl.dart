import 'package:gelato_gallery/core/errors/exception.dart';
import 'package:gelato_gallery/core/network_info/network_info.dart';
import 'package:gelato_gallery/core/utils/quantities.dart';
import 'package:gelato_gallery/core/utils/strings.dart';
import 'package:gelato_gallery/features/gallery/data/sources/gallery_local_data_source.dart';
import 'package:gelato_gallery/features/gallery/data/sources/gallery_remote_data_source.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';
import 'package:gelato_gallery/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:gelato_gallery/features/gallery/domain/repository/gallery_repository.dart';

///Gallery Repository Implementation
class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryLocalDataSource localDataSource;
  final GalleryRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  GalleryRepositoryImpl(
      this.localDataSource, this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Photo>>> getPhotos(
      String page, String limit) async {
    //check for network connection else send error
    if (await networkInfo.isConnected) {
      try {
        //ask for hymn, or return errors
        return Right(await remoteDataSource
            .getPhotos(page, limit)
            .timeout(Quantity.timeOutDuration, onTimeout: () {
          //TimeOut Exception
          throw Exception(ErrorStrings.timeOutError);
        }));
      } on FormatException catch (_) {
        //handling format exceptions here
        return Left(CommonFailure(
          ErrorStrings.jsonSerializationError,
          ErrorStrings.jsonSerializationError,
        ));
      } on ServerException catch (e) {
        //Server related Exceptions. Particularly when not a json is returned
        return Left(ServerFailure(ErrorStrings.serverError, e.message));
      } on Exception catch (e) {
        //General Exceptions
        return Left(
            CommonFailure(e.toString(), ErrorStrings.unhandledException));
      }
    } else {
      //no network connection
      return Left(InternetFailure(
          ErrorStrings.noInternetError, ErrorStrings.noInternetError));
    }
  }
}
