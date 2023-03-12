import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/network/network_info.dart';
import 'package:rick_and_morty/core/utils/repository_helper.dart';
import 'package:rick_and_morty/features/characters/data/datasources/characters_local_data_source.dart';
import 'package:rick_and_morty/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:rick_and_morty/features/characters/data/models/api_character_data_model.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character_params.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';
import 'package:dartz/dartz.dart';

class CharactersRepositoryImpl
    with RepositoryHelper
    implements CharactersRepository {
  final CharactersRemoteDataSource remoteDataSource;
  final CharactersLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CharactersRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  // @override
  // Future<Either<Failure, List<CharacterModel>>> getCharacters(
  //     {int page = 1}) async {
  //   /* if (await networkInfo.isConnected) {
  //     try {
  //       final remoteData = await remoteDataSource.getCharacters(page);
  //       localDataSource.cacheCharacters(remoteData);
  //       return Right(remoteData);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final localData = await localDataSource.getCachedCharacters();
  //       return Right(localData);
  //     } on EmptyCacheException {
  //       return Left(EmptyCacheFailure());
  //     }
  //   } */
  // }

  @override
  Future<Either<Failure, ApiCharacterDataModel>> getCharacters(
    CharacterParams params,
  ) async {
    /* if (await networkInfo.isConnected) {
      try {
        final remoteData =
            await remoteDataSource.getCharactersWithFilter(params);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(EmptyCacheFailure());
    } */
    if (params.filters == null) {
      return fetchCachableOrThrow(
        networkInfo: networkInfo,
        remoteFetcher: () => remoteDataSource.getCharacters(params),
        localFetcher: () => localDataSource.getCachedCharacters(),
        cacher: (newData) => localDataSource.cacheCharacters(newData),
      );
    } else {
      return await fetchOrThrow(
        networkInfo: networkInfo,
        remoteFetcher: () => remoteDataSource.getCharacters(params),
      );
    }
  }
}
