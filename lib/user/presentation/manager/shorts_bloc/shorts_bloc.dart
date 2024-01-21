import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worldhelps/user/data/repositories/shorts_repository.dart';

part 'shorts_event.dart';
part 'shorts_state.dart';

class ShortsBloc extends Bloc<ShortsEvent, ShortsState> {
  final ShortsRepository shortsRepository;
  ShortsBloc({required this.shortsRepository}) : super(ShortsInitial()) {
    on<ShortsUploadRequest>((event, emit) async {
      emit(ShortsLoadingState());
      try {
        await shortsRepository.uploadShorts(
          description: event.description,
          file: event.file,
          profileImage: event.profileImage,
          uid: event.uid,
          username: event.username,
          title: event.title,
          subtitle: event.subtitle,
        );
        emit(ShortsSucessState());
      } catch (e) {
        emit(ShortsErrorState(err: e.toString()));
      }
    });
  }
}
