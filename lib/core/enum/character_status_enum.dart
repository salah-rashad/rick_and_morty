import 'package:flutter/material.dart';

import 'api_filter_enum.dart';

enum CharacterStatus with ApiFilter {
  Alive,
  Dead,
  unknown;

  @override
  List<CharacterStatus> get getValues => values;

  static CharacterStatus? fromName(String? name) {
    try {
      return values.firstWhere((element) => element.name == name);
    } on StateError {
      return null;
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case Alive:
        return Theme.of(context).colorScheme.primary;
      case Dead:
        return Theme.of(context).colorScheme.error;
      case unknown:
        return Theme.of(context).colorScheme.outline;
    }
  }
}
