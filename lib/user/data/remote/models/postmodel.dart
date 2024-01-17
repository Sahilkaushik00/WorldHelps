// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PostModel {
  final String description;
  final String username;
  final String uid;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  PostModel({
    required this.likes,
    required this.description,
    required this.username,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
  });

  PostModel copyWith({
    String? description,
    String? username,
    String? uid,
    String? postId,
    String? datePublished,
    String? postUrl,
    String? profileImage,
  }) {
    return PostModel(
      description: description ?? this.description,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      postId: postId ?? this.postId,
      datePublished: datePublished ?? this.datePublished,
      postUrl: postUrl ?? this.postUrl,
      profileImage: profileImage ?? this.profileImage,
      likes: likes ?? likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'username': username,
      'uid': uid,
      'postId': postId,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profileImage': profileImage,
      'likes': likes,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      description: map['description'] as String,
      username: map['username'] as String,
      uid: map['uid'] as String,
      postId: map['postId'] as String,
      datePublished: map['datePublished'] as String,
      postUrl: map['postUrl'] as String,
      profileImage: map['profileImage'] as String,
      likes: map['likes'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(description: $description, username: $username, uid: $uid, postId: $postId, datePublished: $datePublished, postUrl: $postUrl, profileImage: $profileImage,likes: $likes)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.username == username &&
        other.uid == uid &&
        other.postId == postId &&
        other.datePublished == datePublished &&
        other.postUrl == postUrl &&
        other.profileImage == profileImage &&
        other.likes == likes;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        username.hashCode ^
        uid.hashCode ^
        postId.hashCode ^
        datePublished.hashCode ^
        postUrl.hashCode ^
        profileImage.hashCode ^
        likes.hashCode;
  }

  static PostModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return PostModel(
      username: snap['username'],
      description: snap['description'],
      uid: snap['uid'],
      postUrl: snap['postUrl'],
      profileImage: snap['profileImage'],
      datePublished: snap['datePublished'],
      postId: snap['postId'],
      likes: snap['likes'],
    );
  }
}
