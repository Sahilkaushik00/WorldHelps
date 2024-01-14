import 'dart:developer';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    // check is already login
    on<CheckIsLoggedIn>(
      (event, emit) async {
        User? user = await authRepository.getCurrentUser();
        if (user != null) {
          emit(Authenticated());
        } else {
          emit(UnAuthenticated());
        }
      },
    );

    add(const CheckIsLoggedIn());

    on<SignupRequested>(
      (event, emit) async {
        emit(LoadingState());
        try {
          await authRepository.signup(
            name: event.name,
            bio: event.bio,
            file: event.file,
            email: event.email,
            password: event.password,
          );
          emit(Authenticated());
        } catch (e) {
          emit(AuthErrorState(err: e.toString()));
        }
      },
    );

    on<SigninRequested>((event, emit) async {
      emit(LoadingState());
      try {
        await authRepository.signIn(
          email: event.email,
          password: event.password,
        );
        emit(Authenticated());
      } catch (e) {
        emit(AuthErrorState(err: e.toString()));
      }
    });

    on<ForgotPassword>((event, emit) async {
      emit(LoadingState());
      try {
        await authRepository.forgotPassword(
          email: event.email,
        );
        emit(const ForgorEmailSent());
      } catch (e) {
        emit(AuthErrorState(err: e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(LoadingState());
      log('loading');
      try {
        await authRepository.signOut();
        emit(UnAuthenticated());
        log('Logout sucess');
      } catch (e) {
        log(e.toString());
        emit(AuthErrorState(err: e.toString()));
      }
    });
  }
}
