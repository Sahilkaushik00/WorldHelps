import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_gen_event.dart';
part 'image_gen_state.dart';

class ImageGenBloc extends Bloc<ImageGenEvent, ImageGenState> {
  ImageGenBloc() : super(ImageGenInitial()) {
    on<ImageGenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
