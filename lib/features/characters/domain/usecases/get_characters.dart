import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/utils/usecase.dart';
import 'package:rick_and_morty/features/characters/domain/entities/api_character_data.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character_params.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';
import 'package:dartz/dartz.dart';

class GetCharactersUsecase
    implements Usecase<ApiCharacterData, CharacterParams> {
  final CharactersRepository repository;

  GetCharactersUsecase(this.repository);

  @override
  Future<Either<Failure, ApiCharacterData>> call(CharacterParams params) async {
    return await repository.getCharacters(params);
  }
}
