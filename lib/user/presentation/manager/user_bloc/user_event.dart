part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class OnRefreshUser extends UserEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class OnGetUser extends UserEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
