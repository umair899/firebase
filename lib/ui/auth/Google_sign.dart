import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class GoogleSignInProvider extends ChangeNotifier {
  // final googleSignIn = GoogleSignIn();
  // GoogleSignInAccount? _user;
  // GoogleSignInAccount get user => _user!;
  // Future googleLogin() async {
  //   final googleUser = await googleSignIn.signIn();
  //   if (googleUser == null) return;
  //   _user = googleUser;
  //   notifyListeners();
  //   final googleAuth = await googleUser.authentication;
  //   if (googleAuth.idToken == null) return;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  // }
}