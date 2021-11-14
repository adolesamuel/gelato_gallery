import 'dart:convert';

import 'package:gelato_gallery/core/api/api_endpoints.dart';
import 'package:gelato_gallery/core/errors/exception.dart';
import 'package:gelato_gallery/core/helpers/json_checker.dart';
import 'package:gelato_gallery/core/utils/strings.dart';
import 'package:gelato_gallery/features/gallery/data/models/photo_model.dart';
import 'package:http/http.dart' as http;

abstract class GalleryRemoteDataSource {
  Future<List<PhotoModel>> getPhotos(String page, String limit);
}

class GalleryRemoteDataSourceImpl implements GalleryRemoteDataSource {
  final http.Client client;
  final JsonChecker jsonChecker;

  GalleryRemoteDataSourceImpl(this.client, this.jsonChecker);

  @override
  Future<List<PhotoModel>> getPhotos(String page, String limit) async {
    String url = Endpoint.photosList + '/?page=$page&limit=$limit';

    final response = await client.get(Uri.parse(url));

    //verify data received is a valid json string
    if (await jsonChecker.isJson(response.body)) {
      //decode to map
      //we are expecting a list to be returned  immediately
      List photoMapsInList = await json.decode(response.body);

      List<PhotoModel> photoList = [];

      try {
        photoMapsInList
            .forEach((photoMap) => photoList.add(PhotoModel.fromMap(photoMap)));
      } on Exception catch (e) {
        throw FormatException(e.toString());
      }

      return photoList;
    } else {
      //response is not json
      throw ServerException(ErrorStrings.notAJson);
    }
  }
}
