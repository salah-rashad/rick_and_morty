import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Route route(RouteSettings settings) => MaterialPageRoute(
        builder: (context) => this,
        settings: settings,
      );
}

extension BuildContextExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
