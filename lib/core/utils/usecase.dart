import 'package:rick_and_morty/core/common/data/models/api_params.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Usecase<T, P extends ApiParams> {
  Future<Either<Failure, T>> call(P params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
