import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/ui/FireStore/firestore_list_screen.dart';
import 'package:learn_firebase/ui/auth/login_screen.dart';
import 'package:learn_firebase/ui/posts/past_screen.dart';
import 'package:learn_firebase/ui/upload_image.dart';

class splashServices {
  void islogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      Timer(
          Duration(seconds: 3),
          (() => Navigator.push(
              context, MaterialPageRoute(builder: (context) => FireStoreScreen()))));
    } else {
      Timer(
          Duration(seconds: 3),
          (() => Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen()))));
    }
  }
}
