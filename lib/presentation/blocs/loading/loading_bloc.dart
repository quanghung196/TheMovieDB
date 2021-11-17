import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingInitial()) {
    on<LoadingEvent>((event, emit) {
      if (event is StartLoadingEvent) {
        emit(LoadingStared());
      } else {
        emit(LoadingFinished());
      }
    });
  }
}
