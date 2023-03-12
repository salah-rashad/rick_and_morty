import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;

final List<BlocProvider> providers = [
  BlocProvider(create: (_) => di.sl<CharactersBloc>(), lazy: true),
];
