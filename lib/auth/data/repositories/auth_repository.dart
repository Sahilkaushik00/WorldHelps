import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  // register method
  Future<void> signup({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      user = await _firebaseAuth.currentUser;
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
