part of 'shorts_bloc.dart';

abstract class ShortsEvent extends Equatable {
  const ShortsEvent();
}

class ShortsUploadRequest extends ShortsEvent {
  final String description;
  final File file;
  final String uid;
  final String username;
  final String profileImage;
  final String title;
  final String subtitle;

  const ShortsUploadRequest({required this.title, required this.subtitle, required this.description, required this.file, required this.uid, required this.username, required this.profileImage});

  @override
  List<Object?> get props => [description,file,uid,username,profileImage,title,subtitle];
}