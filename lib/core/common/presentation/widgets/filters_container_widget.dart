import 'package:rick_and_morty/core/common/data/models/api_params.dart';
import 'package:rick_and_morty/core/enum/api_filter_enum.dart';
import 'package:flutter/material.dart';

class FiltersContainerWidget<F extends ApiParamsFilters>
    extends StatelessWidget {
  final F filters;
  final void Function(F filters, bool isAdd) onChangeFilter;

  const FiltersContainerWidget({
    super.key,
    required this.filters,
    required this.onChangeFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Icon(
        //       Icons.filter_alt_sharp,
        //       color: context.colorScheme.onSurfaceVariant,
        //       size: 24,
        //     ),
        //     const SizedBox(width: 8.0),
        //     Text(
        //       "Filters",
        //       style: context.textTheme.titleMedium,
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 8.0,
        // ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.start,
          children: [
            ..._filterChips(),
            _addFilterButton(),
          ],
        )
      ],
    );
  }

  List<Widget> _filterChips() {
    return filters
        .toMap()
        .entries
        .where((element) => element.value != null)
        .map((e) {
      return InputChip(
        label: Text("${e.key}: ${e.value}"),
        onDeleted: () {
          _removeFilter(e.key);
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }).toList();
  }

  Widget _addFilterButton() {
    return MenuAnchor(
      menuChildren: _filtersTreeToMenu(filters.defaultFilters),
      builder: (context, controller, child) {
        return TextButton.icon(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.add_rounded),
          label: const Text("Add Filter"),
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        );
      },
    );
  }

  List<Widget> _filtersTreeToMenu(Map<dynamic, dynamic> tree) {
    return tree.entries.map(
      (e) {
        final value = e.value;

        if (value is List<ApiFilter>) {
          var map = {
            for (var v in value)
              v.name: MapEntry<String, ApiFilter>(e.key.toLowerCase(), v),
          };
          return SubmenuButton(
            menuChildren: _filtersTreeToMenu(map),
            child: Text(e.key),
          );
        } else {
          return MenuItemButton(
            onPressed: () {
              _addFilter(value);
            },
            child: Text(e.key.toString()),
          );
        }
      },
    ).toList();
  }

  void _addFilter(MapEntry<String, ApiFilter> entry) {
    var newFilters = filters.fromMap(Map.fromEntries({entry}));
    onChangeFilter.call(newFilters as F, true);
  }

  void _removeFilter(String key) {
    final map = filters.toMap();
    map.update(key, (value) => null);
    var newFilters = filters.fromMap(map);
    onChangeFilter.call(newFilters as F, false);
  }
}
