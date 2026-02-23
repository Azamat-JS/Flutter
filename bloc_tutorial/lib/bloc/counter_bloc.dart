import 'package:flutter_bloc/flutter_bloc.dart';

class CounterIncremented {}

class CounterBloc extends Bloc<CounterIncremented, int> {
  CounterBloc() : super(0);
}
