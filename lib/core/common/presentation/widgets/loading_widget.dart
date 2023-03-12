import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SliverFillRemaining(
      child: Container(
        alignment: Alignment.center,
        height: 30.0,
        width: 30.0,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
