part of 'api_page_bloc.dart';

abstract class ApiPageState extends Equatable {
  const ApiPageState();

  @override
  List<Object> get props => [];
}

class ApiPageInitial extends ApiPageState {}

class LoadingApiPageState extends ApiPageState {}

class LoadedApiPageState<T extends ApiData, P extends ApiParams>
    extends ApiPageState {
  final T response;
  final P params;
  const LoadedApiPageState(this.response,this.params);

  bool get hasReachedMax => params.page >= response.info.pages;
  bool get isFirstPage => params.page <= 1;

  @override
  List<Object> get props => [response];
}

class ErrorApiPageState<P extends ApiParams> extends ApiPageState {
  final String message;
  final P params;
  const ErrorApiPageState(this.message,this.params);

  @override
  List<Object> get props => [message];
}
