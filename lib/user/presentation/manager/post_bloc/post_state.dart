part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}
class PostLoadingState extends PostState {
  @override
  List<Object> get props => [];
}
class PostSucessState extends PostState {
  @override
  List<Object> get props => [];
}
class PostErrorState extends PostState {
  final String err;

  const PostErrorState({required this.err});
  @override
  List<Object> get props => [err];
}
