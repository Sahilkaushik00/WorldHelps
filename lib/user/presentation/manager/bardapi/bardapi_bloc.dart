import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bardapi_event.dart';
part 'bardapi_state.dart';

class BardapiBloc extends Bloc<BardapiEvent, BardapiState> {
  BardapiBloc() : super(BardapiInitial()) {
    on<BardapiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
