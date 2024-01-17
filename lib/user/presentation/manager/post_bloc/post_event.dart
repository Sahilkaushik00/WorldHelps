part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class PostUploadRequest extends PostEvent {
  final String description;
  final Uint8List file;
  final String uid;
  final String username;
  final String profileImage;

  const PostUploadRequest({required this.description, required this.file, required this.uid, required this.username, required this.profileImage});

  @override
  List<Object?> get props => [description,file,uid,username,profileImage];
}
