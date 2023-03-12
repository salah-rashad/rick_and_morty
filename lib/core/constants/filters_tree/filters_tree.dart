// import 'dart:ui';

// import 'package:rick_and_morty/core/common/data/models/api_params.dart';
// import 'package:rick_and_morty/features/characters/domain/entities/character_params.dart';
// import 'package:dartz/dartz.dart';

// typedef FiltersTree<F extends ApiParamsFilters>
//     = Map<String, Either<F, Map<String, F>>>;

// final FiltersTree<CharacterFilters> characterFiltersTree = {
//   "Status": Right({
//     "Alive": CharacterFilters(status: "Alive"),
//     "Dead": () {},
//     "Unknown": () {},
//   }),
//   "Species": Left(),
//   "Gender": Left(() {}),
// };
