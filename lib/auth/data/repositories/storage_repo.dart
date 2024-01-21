import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
// import 'package:video_compress/video_compress.dart';
// import 'package:flutter/material.dart';

class StorageRepository {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // add image to firebaseStorage
  Future<String> uploadImageToStorage(String childName,Uint8List file,bool isPost,) async {
    Reference ref = _firebaseStorage.ref().child(childName).child(_firebaseAuth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // add video to firebaseStorage
  Future<String> uploadVideoToStorage(String childName,File file,bool isPost,) async {
    Reference ref = _firebaseStorage.ref().child(childName).child(_firebaseAuth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    // UploadTask uploadTask = ref.putFile(await _compressVideo(_compressVideo(file)));
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // _compressVideo(File file)async {
  //   final compressvid = await VideoCompress.compressVideo(file.path,quality: VideoQuality.MediumQuality);
  //   return compressvid!.file;
  // }
}
