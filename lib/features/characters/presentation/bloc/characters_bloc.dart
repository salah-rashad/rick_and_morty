import 'package:rick_and_morty/core/common/presentation/blocs/api_page_bloc/api_page_bloc.dart';
import 'package:rick_and_morty/features/characters/domain/entities/api_character_data.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character_params.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/get_characters.dart';

class CharactersBloc extends ApiPageBloc<ApiCharacterData, CharacterParams> {
  final GetCharactersUsecase getCharacters;

  CharactersBloc({
    required this.getCharacters,
  }) : super(getData: getCharacters);
}
