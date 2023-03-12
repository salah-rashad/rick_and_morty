import 'package:rick_and_morty/core/enum/api_filter_enum.dart';
import 'package:equatable/equatable.dart';

abstract class ApiParams<F extends ApiParamsFilters> extends Equatable {
  final int page;
  final F? filters;

  const ApiParams({
    required this.page,
    required this.filters,
  });

  Map<String, dynamic> toMap() {
    return {
      "page": page,
      ...?filters?.toMap(),
    };
  }

  @override
  List<Object?> get props => [page, filters];

  ApiParams<F> copyWith({int? page, F? filters});
}

abstract class ApiParamsFilters extends Equatable {
  const ApiParamsFilters();

  Map<String, List<ApiFilter>> get defaultFilters;
  Map<String, dynamic> toMap();
  ApiParamsFilters fromMap(Map<String, dynamic> map);
  ApiParamsFilters copyWith();
  ApiParamsFilters merge<T extends ApiParamsFilters>(T other,
      [bool overrideNull = true]) {
    final currentData = toMap();
    final newData = other.toMap();

    final finalData = <String, dynamic>{};
    for (var e in newData.entries) {
      if (e.value == null) {
        if (overrideNull) {
          final currentEntry =
              currentData.entries.firstWhere((element) => element.key == e.key);
          finalData.addEntries([currentEntry]);
        }
      } else {
        finalData.addEntries([e]);
      }
    }

    return fromMap(finalData);
  }
}
