import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class utils{
  void toastmassage(String massage){
    Fluttertoast.showToast(
        msg: massage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}