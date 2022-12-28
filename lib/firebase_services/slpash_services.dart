import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/ui/auth/login_screen.dart';

class splashServices {
  void islogin(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        (() => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()))));
  }
}
