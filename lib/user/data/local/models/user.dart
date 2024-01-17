import 'package:hive_flutter/hive_flutter.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String uid;
  @HiveField(3)
  final String photoUrl;
  @HiveField(4)
  final String bio;
  @HiveField(5)
  final List followers;
  @HiveField(6)
  final List following;

  UserModel({
    required this.username,
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.bio,
    required this.followers,
    required this.following,
  });
}
