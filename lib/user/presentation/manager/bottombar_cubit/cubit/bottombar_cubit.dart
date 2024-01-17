import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottombar_state.dart';

class BottombarCubit extends Cubit<BottombarState> {
  BottombarCubit() : super(BottombarInitial());
}
