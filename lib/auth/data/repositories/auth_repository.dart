import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:worldhelps/auth/data/model/user.dart' as model;
import 'package:worldhelps/auth/data/repositories/storage_repo.dart';
import 'package:worldhelps/user/data/remote/models/user.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    User currentuser = _firebaseAuth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentuser.uid).get();
    return UserModel.fromSnap(snap);
  }

  // register method
  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String bio,
    required Uint8List file,
  }) async {
    try {
      // create user
      UserCredential cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(cred.user!.uid.toString());

      String photourl = await StorageRepository()
          .uploadImageToStorage('profilePics', file, false);
      // add user detail to databse

      model.User user = model.User(
        username: name,
        email: email,
        uid: cred.user!.uid,
        photoUrl: photourl,
        bio: bio,
        followers: [],
        following: [],
      );

      log(user.toJson());

      await _firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toMap());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        throw ('Invalid Email address.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

// User is not authenticated
  Future<User?> getCurrentUser() async {
    User? user;
    try {
      user = _firebaseAuth.currentUser;
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Error occured while signing out ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // logout
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception('Error occured while signing out ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // signin method
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for this email');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong Password Provided!');
      }
      throw Exception('Wrong Crendential!');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      if (EmailValidator.validate(email)) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else {
        throw Exception("Please enter a valid email");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw Exception("This isn't a valid email.");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
