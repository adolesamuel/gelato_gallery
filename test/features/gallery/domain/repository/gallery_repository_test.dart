import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gelato_gallery/core/network_info/network_info.dart';
import 'package:gelato_gallery/features/gallery/data/models/photo_model.dart';
import 'package:gelato_gallery/features/gallery/data/repository_impl/gallery_repository_impl.dart';
import 'package:gelato_gallery/features/gallery/data/sources/gallery_local_data_source.dart';
import 'package:gelato_gallery/features/gallery/data/sources/gallery_remote_data_source.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';
import 'package:gelato_gallery/features/gallery/domain/repository/gallery_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'gallery_repository_test.mocks.dart';

@GenerateMocks([GalleryRemoteDataSource, GalleryLocalDataSource, NetworkInfo])
void main() {
  late MockGalleryRemoteDataSource mockRemoteDataSource;

  late MockGalleryLocalDataSource mockGalleryLocalDataSource;

  late NetworkInfo mockNetworkInfo;

  late GalleryRepository galleryRepository;

  setUp(() {
    mockRemoteDataSource = MockGalleryRemoteDataSource();
    mockGalleryLocalDataSource = MockGalleryLocalDataSource();
    mockNetworkInfo = NetworkInfoImpl(InternetConnectionChecker());
    galleryRepository = GalleryRepositoryImpl(
      mockGalleryLocalDataSource,
      mockRemoteDataSource,
      mockNetworkInfo,
    );
  });

  test('Should get list of photos from Remote Data Source', () async {
    final tPhotoList = <PhotoModel>[];
    const tPage = '1';
    const tLimit = '5';

    //arrange
    when(mockRemoteDataSource.getPhotos(tPage, tLimit))
        .thenAnswer((_) async => tPhotoList);

    //act
    final result = await galleryRepository.getPhotos(tPage, tLimit);

    //assert
    expect(result.fold((l) => null, (r) => r), tPhotoList);
    verify(mockRemoteDataSource.getPhotos(tPage, tLimit));
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
