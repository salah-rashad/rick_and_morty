import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class OfflineFailure extends Failure {}

class EmptyCacheFailure extends Failure {}

class ServerFailure extends Failure {}

class Error404Failure extends Failure {}
