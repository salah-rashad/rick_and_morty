part of 'api_page_bloc.dart';

abstract class ApiPageEvent extends Equatable {
  const ApiPageEvent();

  @override
  List<Object> get props => [];
}

class FetchDataApiPageEvent<P extends ApiParams> extends ApiPageEvent {
  final P params;
  const FetchDataApiPageEvent({required this.params});

  @override
  List<Object> get props => [params];
}

class FetchNextApiPageEvent extends ApiPageEvent {}

class FetchPrevApiPageEvent extends ApiPageEvent {}

class RefreshDataApiPageEvent extends ApiPageEvent {}

// class FilterApiPageEvent<P extends ApiRequest> extends ApiPageEvent {
//   final String status;
//   final P params;

//   const FilterApiPageEvent({
//     required this.status,
//     required this.params,
//   });

//   @override
//   List<Object> get props => [status];
// }
