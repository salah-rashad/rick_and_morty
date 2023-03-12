import 'package:rick_and_morty/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  final BuildContext context;
  final String message;

  AppSnackBar(this.context, {required this.message});

  void showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: context.colorScheme.primary),
        ),
        showCloseIcon: true,
        backgroundColor: context.colorScheme.primaryContainer,
      ),
    );
  }

  void showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: context.colorScheme.error),
        ),
        showCloseIcon: true,
        backgroundColor: context.colorScheme.errorContainer,
      ),
    );
  }
}
