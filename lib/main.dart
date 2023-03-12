import 'package:rick_and_morty/providers.dart';
import 'package:rick_and_morty/core/routes/route_generator.dart';
import 'package:rick_and_morty/core/routes/routes.dart';
import 'package:rick_and_morty/core/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        builder: (context, child) {
          return MaterialApp(
            title: "Rick and Morty",
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.initial,
            onGenerateRoute: RouteGenerator.onGenerate,
            theme: AppTheme().light,
            home: child,
          );
        },
      ),
    );
  }
}
