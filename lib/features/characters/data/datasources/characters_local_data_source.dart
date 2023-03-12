import 'package:rick_and_morty/core/error/exceptions.dart';
import 'package:rick_and_morty/features/characters/data/models/api_character_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String CACHED_CHARACTERS = "CACHED_CHARACTERS";

abstract class CharactersLocalDataSource {
  Future<ApiCharacterDataModel> getCachedCharacters();
  Future<Unit> cacheCharacters(ApiCharacterDataModel newData);
}

class CharactersLocalDataSourceImpl implements CharactersLocalDataSource {
  final SharedPreferences prefs;

  CharactersLocalDataSourceImpl({required this.prefs});

  @override
  Future<Unit> cacheCharacters(ApiCharacterDataModel newData) async {
    final jsonData = newData.toJson();
    await prefs.setString(CACHED_CHARACTERS, jsonData);
    return Future.value(unit);
  }

  @override
  Future<ApiCharacterDataModel> getCachedCharacters() {
    String? jsonData = prefs.getString(CACHED_CHARACTERS);

    if (jsonData != null) {
      // List decodedJsonData = json.decode(jsonData);
      ApiCharacterDataModel characters =
          ApiCharacterDataModel.fromJson(jsonData);
      return Future.value(characters);
    } else {
      throw EmptyCacheException();
    }
  }
}
