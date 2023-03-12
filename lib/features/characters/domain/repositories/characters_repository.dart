import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/features/characters/domain/entities/api_character_data.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character_params.dart';
import 'package:dartz/dartz.dart';

abstract class CharactersRepository {
  Future<Either<Failure, ApiCharacterData>> getCharacters(
    CharacterParams params,
  );
}
