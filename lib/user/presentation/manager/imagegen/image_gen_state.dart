part of 'image_gen_bloc.dart';

abstract class ImageGenState extends Equatable {
  const ImageGenState();
}

class ImageGenInitial extends ImageGenState {
  @override
  List<Object> get props => [];
}
