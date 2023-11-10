import 'dart:developer';

import 'package:configs/configs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AuthFirebaseDataSource {
  late final GoogleSignIn _googleSignIn;

  AuthFirebaseDataSource() {
    if (kIsWeb) {
      _googleSignIn = GoogleSignIn(clientId: BuildConfig.googleClientId);
    } else {
      _googleSignIn = GoogleSignIn.standard();
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser;

      if (kIsWeb) {
        googleUser = await _googleSignIn.signInSilently();
      } else {
        googleUser = await _googleSignIn.signIn();
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait(
          [FirebaseAuth.instance.signOut(), _googleSignIn.signOut()]);
    } catch (err) {
      log(err.toString(), name: 'Log out error');
    }
  }
}
