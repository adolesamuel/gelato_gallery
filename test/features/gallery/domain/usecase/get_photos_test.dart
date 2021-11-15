import 'package:dartz/dartz.dart';
import 'package:gelato_gallery/features/gallery/domain/entities/photo.dart';
import 'package:gelato_gallery/features/gallery/domain/repository/gallery_repository.dart';
import 'package:gelato_gallery/features/gallery/domain/usecases/get_photos.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'get_photos_test.mocks.dart';

@GenerateMocks([GalleryRepository])
void main() {
  late MockGalleryRepository mockGalleryRepository;

  late GetPhotos usecase;

  setUp(() {
    mockGalleryRepository = MockGalleryRepository();
    usecase = GetPhotos(mockGalleryRepository);
  });
  test('should  get photos from the repository', () async {
    final tPhotoList = <Photo>[];
    const tPage = '1';
    const tLimit = '5';

    // arrange
    when(mockGalleryRepository.getPhotos(tPage, tLimit))
        .thenAnswer((_) async => Right(tPhotoList));

    //act
    final result = await usecase(GetPhotosParams(tPage, tLimit));

    //assert
    expect(result, Right(tPhotoList));
    verify(mockGalleryRepository.getPhotos(tPage, tLimit));
    verifyNoMoreInteractions(mockGalleryRepository);
  });
}
