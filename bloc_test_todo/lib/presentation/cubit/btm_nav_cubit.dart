import 'package:flutter_bloc/flutter_bloc.dart';

class BtmNavCubit extends Cubit<int> {
  BtmNavCubit() : super(0);

  void changeTab(int index) {
    emit(index);
  }
}
