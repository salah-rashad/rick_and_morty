import 'package:rick_and_morty/core/common/data/models/api_params.dart';
import 'package:rick_and_morty/core/enum/api_filter_enum.dart';
import 'package:rick_and_morty/core/enum/character_gender_enum.dart';
import 'package:rick_and_morty/core/enum/character_species_enum.dart';
import 'package:rick_and_morty/core/enum/character_status_enum.dart';

class CharacterParams extends ApiParams<CharacterFilters> {
  const CharacterParams({required super.page, super.filters});

  @override
  CharacterParams copyWith({int? page, CharacterFilters? filters}) {
    return CharacterParams(
      page: page ?? this.page,
      filters: filters ?? this.filters,
    );
  }
}

class CharacterFilters extends ApiParamsFilters {
  final CharacterStatus? status;
  final CharacterSpecies? species;
  final CharacterGender? gender;

  const CharacterFilters({
    this.status,
    this.species,
    this.gender,
  });

  @override
  List<Object?> get props => [status, species, gender];

  @override
  Map<String, List<ApiFilter>> get defaultFilters => {
        "Status": CharacterStatus.values,
        "Species": CharacterSpecies.values,
        "Gender": CharacterGender.values,
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'species': species,
      'gender': gender,
    };
  }

  @override
  CharacterFilters copyWith({
    CharacterStatus? status,
    CharacterSpecies? species,
    CharacterGender? gender,
  }) {
    return CharacterFilters(
      status: status ?? this.status,
      species: species ?? this.species,
      gender: gender ?? this.gender,
    );
  }

  @override
  CharacterFilters fromMap(Map<String, dynamic> map) {
    return CharacterFilters(
      status: map['status'],
      species: map['species'],
      gender: map['gender'],
    );
  }
}
