import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:learn_firebase/utiles/utiles.dart';
import 'package:learn_firebase/widgets/round_button.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final pastcontroller = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('asif');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 4,
              controller: pastcontroller,
              decoration: const InputDecoration(
                hintText: 'What is in your mind?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundButton(
                title: 'Add',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  databaseRef.child('12').set({
                    'desc': pastcontroller.text.toString(),
                    'ss ': '2'
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    utils().toastmassage('Post Added');
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    utils().toastmassage(error.toString());
                  });
                })
          ],
        ),
      ));
  }
}