import 'package:rick_and_morty/core/utils/extensions.dart';
import 'package:rick_and_morty/core/routes/routes.dart';
import 'package:rick_and_morty/features/characters/presentation/pages/characters_page.dart';
import 'package:rick_and_morty/features/home/home_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.HOME:
        return const HomePage().route(settings);
      case Routes.CHARACTERS:
        return const CharactersPage().route(settings);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text("Route Not Found"),
            ),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
