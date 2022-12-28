import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:learn_firebase/ui/auth/login_screen.dart';
import 'package:learn_firebase/utiles/utiles.dart';
import 'package:learn_firebase/widgets/round_button.dart';
import 'package:firebase_core/firebase_core.dart';

class signupScreen extends StatefulWidget {
  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailControllar = TextEditingController();
  final passwordControllar = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControllar.dispose();
    passwordControllar.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Center(
          child: Text('Signup'),
        ),
      ),
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
                    SizedBox(height: 10),
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
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundButton(
              title: 'Signup',
              loading: loading,
              onTap: () {
                try {
                  if (_formkey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _auth
                      .createUserWithEmailAndPassword(
                          email: emailControllar.text.toString(),
                          password: passwordControllar.text.toString())
                      .then((value) {
                    setState(() {
                      loading = false;
                    });
                  });
                }
                }on FirebaseAuthException catch (e) {
                  print(e.message);
                  setState(() {
                    loading=false;
                  });
                }
                
                
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
              Text("Already have an account"),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("Login"))
            ],
          )
        ],
      ),
    );
  }
}
