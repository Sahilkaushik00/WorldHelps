part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String bio;
  final Uint8List file;
  const SignupRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.bio,
    required this.file,
  });

  @override
  List<Object?> get props => [email, password];
}

class SigninRequested extends AuthEvent {
  final String email;
  final String password;
  const SigninRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class ForgotPassword extends AuthEvent {
  final String email;
  const ForgotPassword({required this.email});

  @override
  List<Object?> get props => [email];
}

class CheckIsLoggedIn extends AuthEvent {
  const CheckIsLoggedIn();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
