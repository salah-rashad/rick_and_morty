import 'package:rick_and_morty/core/common/presentation/widgets/custom_sliver_grid_widget.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_card.dart';
import 'package:flutter/material.dart';

class CharactersGridWidget extends StatelessWidget {
  final List<Character> characters;
  const CharactersGridWidget({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return CustomSliverGridWidget(
      itemCount: characters.length,
      itemBuilder: (context, index) => CharacterCard(
        characters[index],
      ),
    );
  }
}
