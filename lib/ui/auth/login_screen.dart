import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:learn_firebase/ui/auth/signup_screen.dart';
import 'package:learn_firebase/widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailControllar = TextEditingController();
  final passwordControllar = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailControllar.dispose();
    passwordControllar.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
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
                title: 'Login',
                onTap: () {
                  if (_formkey.currentState!.validate()) ;
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
                Text("Don't have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signupScreen()));
                    },
                    child: Text("Signup"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
