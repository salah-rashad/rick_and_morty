import 'api_filter_enum.dart';

enum CharacterSpecies with ApiFilter {
  Human,
  Alien,
  Humanoid,
  Mythological,
  Disease,
  Robot,
  Cronenberg,
  unknown;

  @override
  List<CharacterSpecies> get getValues => values;

  static CharacterSpecies? fromName(String? name) {
    try {
      return values.firstWhere((element) => element.name == name);
    } on StateError {
      return null;
    }
  }
}
