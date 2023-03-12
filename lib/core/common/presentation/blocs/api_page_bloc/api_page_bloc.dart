import 'package:rick_and_morty/core/common/data/models/api_data_info.dart';
import 'package:rick_and_morty/core/common/data/models/api_params.dart';
import 'package:rick_and_morty/core/constants/strings/failures.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'api_page_event.dart';
part 'api_page_state.dart';

abstract class ApiPageBloc<T extends ApiData, P extends ApiParams>
    extends Bloc<ApiPageEvent, ApiPageState> {
  final Usecase<T, P> getData;

  ApiPageBloc({
    required this.getData,
  }) : super(ApiPageInitial()) {
    on<FetchDataApiPageEvent<P>>((event, emit) async {
      emit(LoadingApiPageState());
      final failureOrData = await getData.call(event.params);
      emit(stateFromEither(failureOrData, event.params));
    });

    on<RefreshDataApiPageEvent>(
      (event, emit) async {
        final currentState = state;
        if (currentState is LoadedApiPageState<T, P>) {
          final params = currentState.params;
          emit(LoadingApiPageState());
          final failureOrData = await getData.call(params);
          emit(stateFromEither(failureOrData, params));
        }
      },
    );

    on<FetchNextApiPageEvent>((event, emit) async {
      final currentState = state;
      if (currentState is LoadedApiPageState<T, P>) {
        final params = currentState.params;
        final currentPage = params.page;

        if (currentState.hasReachedMax) return;

        emit(LoadingApiPageState());
        final newParams = params.copyWith(page: currentPage + 1);
        final failureOrData = await getData.call(newParams as P);
        emit(stateFromEither(failureOrData, newParams));
      }
    });

    on<FetchPrevApiPageEvent>((event, emit) async {
      final currentState = state;
      if (currentState is LoadedApiPageState<T, P>) {
        final params = currentState.params;
        final currentPage = params.page;

        if (currentPage <= 1) return;

        emit(LoadingApiPageState());
        final newParams = params.copyWith(page: currentPage - 1);
        final failureOrData = await getData.call(newParams as P);
        emit(stateFromEither(failureOrData, newParams));
      }
    });
  }

  @mustCallSuper
  ApiPageState stateFromEither(Either<Failure, T> either, P params) {
    return either.fold(
      (failure) => ErrorApiPageState(mapFailureToMessage(failure), params),
      (data) => LoadedApiPageState(data, params),
    );
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case Error404Failure:
        return ERROR_404_FAILURE_MESSAGE;
      default:
        return "Unexpected Error! - Please try again later!";
    }

    /* 
    if (failure is ServerFailure) {
      return failure.message ?? SERVER_FAILURE_MESSAGE;
    } else if (failure is EmptyCacheFailure) {
      return EMPTY_CACHE_FAILURE_MESSAGE;
    } else if (failure is OfflineFailure) {
      return OFFLINE_FAILURE_MESSAGE;
    }
    return "Unexpected Error! - Please try again later!"; 
    */
  }
}
