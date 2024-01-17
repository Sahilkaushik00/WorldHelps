// import 'dart:typed_data';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:worldhelps/auth/data/repositories/storage_repo.dart';
import 'package:worldhelps/user/data/remote/models/postmodel.dart';

class PostRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // upload post
  Future<void> uploadPost({
    required String description,
    required Uint8List file,
    required String uid,
    required String username,
    required String profileImage,
  }) async {
    try {
      String photourl =
          await StorageRepository().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      PostModel post = PostModel(
        description: description,
        username: username,
        uid: uid,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photourl,
        profileImage: profileImage,
        likes: [],
      );

      _firebaseFirestore.collection('posts').doc(postId).set(post.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
