import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<OnRefreshUser>((event, emit) async {
      emit(UserLoadedState());
      try {
        log('on refersh');
        await userRepository.refreshUser();
        emit(UserRefreshedState());
      } catch (e) {
        log('on error');
        emit(UserErrorState(err: e.toString()));
      }
    });
    add(OnRefreshUser());
  }
}
