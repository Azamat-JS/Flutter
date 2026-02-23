import 'package:flutter_bloc/flutter_bloc.dart';

class CounterIncremented {}

class CounterDecremented {}

class CounterBloc extends Bloc<dynamic, int> {
  CounterBloc() : super(0) {
    on<CounterIncremented>((event, emit) {
      emit(state + 1);
    });

    on<CounterDecremented>((event, emit) {
      if (state == 0) return;
      emit(state - 1);
    });
  }
}
