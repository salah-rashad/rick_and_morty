import 'dart:developer';

import 'package:rick_and_morty/core/constants/api_urls.dart';
import 'package:rick_and_morty/core/error/exceptions.dart';
import 'package:rick_and_morty/features/characters/data/models/api_character_data_model.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character_params.dart';
import 'package:dio/dio.dart';

abstract class CharactersRemoteDataSource {
  Future<ApiCharacterDataModel> getCharacters(CharacterParams params);
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final Dio dio;

  CharactersRemoteDataSourceImpl({required this.dio}) {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: "application/json",
      responseType: ResponseType.json,
    );

    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {
        switch (e.response?.statusCode) {
          case 404:
            handler.next(Error404Exception(requestOptions: e.requestOptions));
            break;
          default:
            handler.next(ServerException(requestOptions: e.requestOptions));
        }
      },
    ));
  }

  // @override
  // Future<List<CharacterModel>> getCharacters(int page) async {
  //   final url = ApiUrls.CHARACTERS;
  //   final response = await dio.get(
  //     url.url,
  //     queryParameters: {
  //       "page": page,
  //     },
  //     options: Options(
  //       headers: {"Content-Type": "application/json"},
  //     ),
  //   );

  //   if (response.statusCode == 200) {
  //     final List decodedData = json.decode(response.data);
  //     final List<CharacterModel> characterModels =
  //         decodedData.map((e) => CharacterModel.fromJson(e)).toList();
  //     return characterModels;
  //   } else {
  //     throw ServerException();
  //   }
  // }

  @override
  Future<ApiCharacterDataModel> getCharacters(
    CharacterParams params,
  ) async {
    final url = ApiUrls.CHARACTERS;

    final response = await dio.get(
      url.url,
      queryParameters: params.toMap(),
    );

    if (response.statusCode == 200) {
      final jsonData = response.data;
      final characterModels = ApiCharacterDataModel.fromMap(jsonData);
      log(response.realUri.queryParameters.toString());
      return characterModels;
    } else {
      throw ServerException(requestOptions: response.requestOptions);
    }
  }
}
