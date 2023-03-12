// import 'package:rick_and_morty/core/constants/strings/failures.dart';
// import 'package:rick_and_morty/core/error/failures.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// abstract class ScrollHeaderViewBloc<E, S, T extends Object> extends Bloc<E, S> {
//   ScrollHeaderViewBloc(S initialState) : super(initialState){
//     on((event, emit) => null)
//   }
  

//   S failureState(String message);
//   S loadedState(T data);

//   S stateFromEither(Either<Failure, T> either) {
//     return either.fold(
//       (failure) => failureState(mapFailureToMessage(failure)),
//       (data) => loadedState(data),
//     );
//   }

//   String mapFailureToMessage(Failure failure) {
//     /* if (failure is ServerFailure) {
//       return failure.message ?? SERVER_FAILURE_MESSAGE;
//     } else if (failure is EmptyCacheFailure) {
//       return EMPTY_CACHE_FAILURE_MESSAGE;
//     } else if (failure is OfflineFailure) {
//       return OFFLINE_FAILURE_MESSAGE;
//     }

//     return "Unexpected Error! - Please try again later!"; */

//     switch (failure.runtimeType) {
//       case EmptyCacheFailure:
//         return EMPTY_CACHE_FAILURE_MESSAGE;
//       case OfflineFailure:
//         return OFFLINE_FAILURE_MESSAGE;
//       case ServerFailure:
//         return SERVER_FAILURE_MESSAGE;
//       case Error404Failure:
//         return ERROR_404_FAILURE_MESSAGE;
//       default:
//         return "Unexpected Error! - Please try again later!";
//     }
//   }
// }


