import 'package:flutter/material.dart';

import 'package:rick_and_morty/core/utils/extensions.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;

  const MessageDisplayWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          message,
          style: context.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
