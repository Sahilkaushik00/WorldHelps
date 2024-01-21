// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

class ShortsModel {
  final String description;
  final String username;
  final String uid;
  final String postId;
  final datePublished;
  final String shortsUrl;
  final String profileImage;
  final String title;
  final String subtitle;
  final likes;

  ShortsModel({
    required this.likes,
    required this.description,
    required this.username,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.shortsUrl,
    required this.profileImage,
    required this.title,
    required this.subtitle,
  });

  ShortsModel copyWith({
    String? description,
    String? username,
    String? uid,
    String? postId,
    String? datePublished,
    String? postUrl,
    String? profileImage,
    String? title,
    String? subtitle,
  }) {
    return ShortsModel(
      description: description ?? this.description,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      postId: postId ?? this.postId,
      datePublished: datePublished ?? this.datePublished,
      shortsUrl: postUrl ?? this.shortsUrl,
      profileImage: profileImage ?? this.profileImage,
      likes: likes ?? likes,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'username': username,
      'uid': uid,
      'postId': postId,
      'datePublished': datePublished,
      'shortsUrl': shortsUrl,
      'profileImage': profileImage,
      'likes': likes,
      'title': title,
      'subtitle': subtitle,
    };
  }

  factory ShortsModel.fromMap(Map<String, dynamic> map) {
    return ShortsModel(
      description: map['description'] as String,
      username: map['username'] as String,
      uid: map['uid'] as String,
      postId: map['postId'] as String,
      datePublished: map['datePublished'] as String,
      shortsUrl: map['shortsUrl'] as String,
      profileImage: map['profileImage'] as String,
      likes: map['likes'] as dynamic,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShortsModel.fromJson(String source) =>
      ShortsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(description: $description, username: $username, uid: $uid, postId: $postId, datePublished: $datePublished, shortsUrl: $shortsUrl, profileImage: $profileImage,likes: $likes,title: $title,subtitle: $subtitle)';
  }

  @override
  bool operator ==(covariant ShortsModel other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.username == username &&
        other.uid == uid &&
        other.postId == postId &&
        other.datePublished == datePublished &&
        other.shortsUrl == shortsUrl &&
        other.profileImage == profileImage &&
        other.likes == likes &&
        other.title == title &&
        other.subtitle == subtitle;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        username.hashCode ^
        uid.hashCode ^
        postId.hashCode ^
        datePublished.hashCode ^
        shortsUrl.hashCode ^
        profileImage.hashCode ^
        likes.hashCode ^
        title.hashCode ^
        subtitle.hashCode;
  }

  static ShortsModel fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return ShortsModel(
      username: snap['username'],
      description: snap['description'],
      uid: snap['uid'],
      shortsUrl: snap['shortsUrl'],
      profileImage: snap['profileImage'],
      datePublished: snap['datePublished'],
      postId: snap['postId'],
      likes: snap['likes'],
      title: snap['title'],
      subtitle: snap['subtitle'],
    );
  }
}
