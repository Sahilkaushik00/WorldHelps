part of 'shorts_bloc.dart';

abstract class ShortsState extends Equatable {
  const ShortsState();
}

class ShortsInitial extends ShortsState {
  @override
  List<Object> get props => [];
}
class ShortsLoadingState extends ShortsState {
  @override
  List<Object> get props => [];
}
class ShortsSucessState extends ShortsState {
  @override
  List<Object> get props => [];
}
class ShortsErrorState extends ShortsState {
  final String err;

  const ShortsErrorState({required this.err});
  @override
  List<Object> get props => [err];
}