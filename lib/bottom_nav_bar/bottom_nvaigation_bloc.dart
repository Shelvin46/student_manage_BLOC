import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nvaigation_event.dart';
part 'bottom_nvaigation_state.dart';

class BottomNvaigationBloc
    extends Bloc<BottomNvaigationEvent, BottomNvaigationState> {
  BottomNvaigationBloc() : super(BottomNvaigationInitial()) {
    on<AccountList>((event, emit) {
      return emit(BottomNvaigationState(count: 1));
    });
    on<HomeView>((event, emit) {
      return emit(BottomNvaigationState(count: 0));
    });
  }
}
