part of 'bardapi_bloc.dart';

abstract class BardapiState extends Equatable {
  const BardapiState();
}

class BardapiInitial extends BardapiState {
  @override
  List<Object> get props => [];
}
