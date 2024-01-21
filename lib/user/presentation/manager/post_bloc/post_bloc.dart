// import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/post_repo.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<PostUploadRequest>((event, emit) async {
      emit(PostLoadingState());
      try {
        await postRepository.uploadPost(
          description: event.description,
          file: event.file,
          profileImage: event.profileImage,
          uid: event.uid,
          username: event.username,
        );
        emit(PostSucessState());
      } catch (e) {
        emit(PostErrorState(err: e.toString()));
      }
    });
  }
}
