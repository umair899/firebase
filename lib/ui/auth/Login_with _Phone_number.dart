import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/ui/auth/verify.dart';
import 'package:learn_firebase/utiles/utiles.dart';
import 'package:learn_firebase/widgets/round_button.dart';

class LoginWithPhomwNumber extends StatefulWidget {
  const LoginWithPhomwNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhomwNumber> createState() => _LoginWithPhomwNumberState();
}

class _LoginWithPhomwNumberState extends State<LoginWithPhomwNumber> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final PhoneNumberControllar = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextFormField(
              controller: PhoneNumberControllar,
              decoration: InputDecoration(
                hintText: "+1 345 2244 5566",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
              title: 'Login',
              onTap: () {
                auth.verifyPhoneNumber(
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      utils().toastmassage(e.toString());
                    },
                    codeSent: (String verificationID, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyScreen(
                                    verificationID: verificationID,
                                  )));
                    },
                    codeAutoRetrievalTimeout: (e) {
                      utils().toastmassage(e.toString());
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
