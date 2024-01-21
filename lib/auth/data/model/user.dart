// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  final String username;
  final String email;
  final String uid;
  final String photoUrl;
  final String bio;
  final List followers;
  final List following;

  User({
    required this.username,
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.bio,
    required this.followers,
    required this.following,
  });

  User copyWith({
    String? name,
    String? email,
    String? uid,
    String? photoUrl,
    String? bio,
    List? followers,
    List? following,
  }) {
    return User(
      username: name ?? username,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': username,
      'email': email,
      'uid': uid,
      'photoUrl': photoUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['name'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      photoUrl: map['photoUrl'] as String,
      bio: map['bio'] as String,
      followers: List.from((map['followers'] as List)),
      following: List.from((map['following'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(name: $username, email: $email, uid: $uid, photoUrl: $photoUrl, bio: $bio, followers: $followers, following: $following)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.uid == uid &&
        other.photoUrl == photoUrl &&
        other.bio == bio &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following);
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        uid.hashCode ^
        photoUrl.hashCode ^
        bio.hashCode ^
        followers.hashCode ^
        following.hashCode;
  }
}
