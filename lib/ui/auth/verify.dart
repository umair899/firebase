import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  final String verificationID;
  const VerifyScreen({Key? key, required this.verificationID})
      : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyState();
}

class _VerifyState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("verify")),
      body: Column(
        children: [],
      ),
    );
  }
}
