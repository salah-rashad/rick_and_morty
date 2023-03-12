import 'dart:convert';

import 'package:rick_and_morty/core/common/data/models/api_data_info.dart';
import 'package:rick_and_morty/features/characters/data/models/character_model.dart';
import 'package:rick_and_morty/features/characters/domain/entities/api_character_data.dart';

class ApiCharacterDataModel extends ApiCharacterData {
  const ApiCharacterDataModel({
    required super.info,
    required super.results,
  });

  Map<String, dynamic> toMap() {
    return {
      'info': info.toMap(),
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory ApiCharacterDataModel.fromMap(Map<String, dynamic> map) {
    return ApiCharacterDataModel(
      info: ApiDataInfo.fromMap(map['info']),
      results: List<CharacterModel>.from(
          map['results']?.map((x) => CharacterModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiCharacterDataModel.fromJson(String source) =>
      ApiCharacterDataModel.fromMap(json.decode(source));
}
