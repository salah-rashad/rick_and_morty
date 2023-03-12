import 'package:auto_size_text/auto_size_text.dart';
import 'package:rick_and_morty/core/common/presentation/widgets/ink_wrapper.dart';
import 'package:rick_and_morty/core/enum/character_status_enum.dart';
import 'package:rick_and_morty/core/utils/extensions.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  const CharacterCard(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWrapper(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(12.0)),
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AutoSizeText(
                    character.name,
                    style: context.textTheme.titleLarge,
                    maxLines: 2,
                    minFontSize: 16,
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getCharacterStatusWidget(context, character.status),
                      const SizedBox(width: 8.0),
                      Flexible(
                        child: Text(
                          character.species,
                          style: context.textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCharacterStatusWidget(BuildContext context, String status) {
    final statusEnum = CharacterStatus.fromName(status);
    return Material(
      type: MaterialType.circle,
      color: statusEnum?.color(context),
      child: const SizedBox.square(dimension: 8.0),
    );
  }
}
