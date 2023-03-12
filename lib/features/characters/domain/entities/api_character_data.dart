import 'package:rick_and_morty/core/common/data/models/api_data_info.dart';
import 'package:rick_and_morty/features/characters/data/models/character_model.dart';

class ApiCharacterData extends ApiData<CharacterModel> {
  const ApiCharacterData({
    required super.info,
    required super.results,
  });
}
