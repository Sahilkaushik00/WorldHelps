part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserRefreshedState extends UserState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserErrorState extends UserState {
  final String err;

  const UserErrorState({required this.err});
  @override
  List<Object?> get props => [err];
}

class UserLoadedState extends UserState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
