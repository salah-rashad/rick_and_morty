import 'package:rick_and_morty/core/routes/routes.dart';
import 'package:rick_and_morty/core/style/custom_button_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick and Morty"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton.tonalIcon(
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.CHARACTERS),
                label: const Text("Characters"),
                icon: const Icon(Icons.people_alt_rounded),
                style: CustomButtonStyles().homeButtonStyle,
              ),
              const SizedBox(height: 16.0),
              FilledButton.tonalIcon(
                onPressed: () => Navigator.pushNamed(context, Routes.LOCATIONS),
                label: const Text("Locations"),
                icon: const Icon(Icons.location_pin),
                style: CustomButtonStyles().homeButtonStyle,
              ),
              const SizedBox(height: 16.0),
              FilledButton.tonalIcon(
                onPressed: () => Navigator.pushNamed(context, Routes.EPISODES),
                label: const Text("Episodes"),
                icon: const Icon(Icons.video_collection_rounded),
                style: CustomButtonStyles().homeButtonStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
