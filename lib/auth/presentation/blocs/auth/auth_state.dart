part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthErrorState extends AuthState {
  final String err;

  const AuthErrorState({required this.err});
  @override
  List<Object> get props => [err];
}

class ForgorEmailSent extends AuthState {
  const ForgorEmailSent();
  @override
  List<Object> get props => [];
}
