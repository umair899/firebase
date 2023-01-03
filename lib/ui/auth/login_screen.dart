import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_firebase/ui/auth/Login_with%20_Phone_number.dart';
import 'package:learn_firebase/ui/auth/signup_screen.dart';
import 'package:learn_firebase/utiles/utiles.dart';
import 'package:learn_firebase/widgets/round_button.dart';

import '../posts/past_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailControllar = TextEditingController();
  final passwordControllar = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControllar.dispose();
    passwordControllar.dispose();
  }

  void Login() async {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
      email: emailControllar.text,
      password: passwordControllar.text,
    )
        .then((value) {
      utils().toastmassage(value.user!.email.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      utils().toastmassage(error.toString());
      setState(() {
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(child: Text('Login'))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailControllar,
                          decoration: const InputDecoration(
                              hintText: 'email',
                              // helperText: 'enter email i.e:john@gmail.com',
                              prefixIcon: Icon(Icons.alternate_email)),
                          validator: (Value) {
                            if (Value!.isEmpty) {
                              return 'enter email';
                            }
                            return null;
                          }),
                      SizedBox(height: 8),
                      TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordControllar,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Password',
                              // helperText: 'enter password ',
                              prefixIcon: Icon(Icons.lock_open)),
                          validator: (Value) {
                            if (Value!.isEmpty) {
                              return 'enter your password';
                            }
                            return null;
                          }),
                    ],
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundButton(
                title: 'Login',
                loading: loading,
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    Login();
                  }
                  ;
                },
              ),
            ),
            SizedBox(
              height: 23,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signupScreen()));
                    },
                    child: Text("Signup"))
              ],

              //   ),InkWell(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => LoginWithPhomwNumber()));
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     child: Container(
              //       height: 50,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(50),
              //         border: Border.all(color: Colors.deepPurple),
              //       ),
              //       child: Center(child: Text("Login With Phone Number")),
              //     ),
              //   ),
              //
            ),
            
          ],
        ),
      ),
    );
  }
}
