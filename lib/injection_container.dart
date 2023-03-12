import 'package:rick_and_morty/core/network/network_info.dart';
import 'package:rick_and_morty/features/characters/data/datasources/characters_local_data_source.dart';
import 'package:rick_and_morty/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:rick_and_morty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/features/characters/domain/usecases/get_characters.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ~~~~~~~~ Core ~~~~~~~~ //

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // ~~~~~~~~ Services ~~~~~~~~ //

  sl.registerLazySingleton(() => Dio());
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // ~~~~~~~~ Features - Characters ~~~~~~~~ //

  //! Blocs
  sl.registerLazySingleton(() => CharactersBloc(getCharacters: sl()));

  //! Usecases
  sl.registerLazySingleton(() => GetCharactersUsecase(sl()));

  //! Repositories
  sl.registerLazySingleton<CharactersRepository>(
    () => CharactersRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //! Data Sources
  sl.registerLazySingleton<CharactersRemoteDataSource>(
      () => CharactersRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<CharactersLocalDataSource>(
      () => CharactersLocalDataSourceImpl(prefs: sl()));

  // ~~~~~~~~ Features - Locations ~~~~~~~~ //

  // ~~~~~~~~ Features - Episodes ~~~~~~~~ //
}
