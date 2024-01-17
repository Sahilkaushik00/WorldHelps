import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String username;
  final String email;
  final String uid;
  final String photoUrl;
  final String bio;
  final List followers;
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

  UserModel copyWith({
    String? username,
    String? email,
    String? uid,
    String? photoUrl,
    String? bio,
    List? followers,
    List? following,
  }) {
    return UserModel(
      username: username ?? this.username,
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
      'username': username,
      'email': email,
      'uid': uid,
      'photoUrl': photoUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      photoUrl: map['photoUrl'] as String,
      bio: map['bio'] as String,
      followers: List.from((map['followers'] as List)),
      following: List.from((map['following'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, uid: $uid, photoUrl: $photoUrl, bio: $bio, followers: $followers, following: $following)';
  }

  @override
  bool operator ==(covariant UserModel other) {
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

  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      username: snap['name'],
      email: snap['email'],
      bio: snap['bio'],
      following: snap['following'],
      photoUrl: snap['photoUrl'],
      uid: snap['uid'],
      followers: snap['followers'],
    );
  }
}
