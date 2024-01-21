import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:worldhelps/auth/data/repositories/storage_repo.dart';
import 'package:worldhelps/user/data/remote/models/shortsmodel.dart';

class ShortsRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // upload post
  Future<void> uploadShorts({
    required String description,
    required File file,
    required String uid,
    required String username,
    required String profileImage,
    required String title,
    required String subtitle,
  }) async {
    try {
      String shortsurl = await StorageRepository().uploadVideoToStorage('shorts', file, true);

      String postId = const Uuid().v1();

      ShortsModel post = ShortsModel(
        description: description,
        username: username,
        uid: uid,
        postId: postId,
        datePublished: DateTime.now(),
        shortsUrl: shortsurl,
        profileImage: profileImage,
        likes: [],
        title: title,
        subtitle: subtitle,
      );

      _firebaseFirestore.collection('shorts').doc(postId).set(post.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
