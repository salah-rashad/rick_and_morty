

import 'api_filter_enum.dart';

enum CharacterGender with ApiFilter{
  Female,
  Male,
  Genderless,
  unknown;

    @override
  List<CharacterGender> get getValues => values;


  static CharacterGender? fromName(String? name) {
    try {
      return values.firstWhere((element) => element.name == name);
    } on StateError {
      return null;
    }
  }
}
