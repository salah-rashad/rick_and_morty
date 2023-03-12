import 'package:rick_and_morty/core/error/exceptions.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/network/network_info.dart';
import 'package:dartz/dartz.dart';

typedef RemoteFetcher<T> = Future<T> Function();
typedef LocalFetcher<T> = Future<T> Function();
typedef Cacher<T> = void Function(T newData);

mixin RepositoryHelper {
  Future<Either<Failure, T>> fetchCachableOrThrow<T>({
    required NetworkInfo networkInfo,
    required RemoteFetcher<T> remoteFetcher,
    required RemoteFetcher<T> localFetcher,
    required Cacher<T> cacher,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteFetcher.call();
        cacher.call(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on Error404Exception {
        return Left(Error404Failure());
      }
    } else {
      try {
        final localData = await localFetcher.call();
        return Right(localData);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  Future<Either<Failure, T>> fetchOrThrow<T>({
    required NetworkInfo networkInfo,
    required RemoteFetcher<T> remoteFetcher,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteFetcher.call();
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on Error404Exception {
        return Left(Error404Failure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
