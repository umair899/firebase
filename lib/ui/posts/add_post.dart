import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:learn_firebase/utiles/utiles.dart';
import 'package:learn_firebase/widgets/round_button.dart';

class AddpostScreen extends StatefulWidget {
  const AddpostScreen({Key? key}) : super(key: key);

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}

class _AddpostScreenState extends State<AddpostScreen> {
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
      ),
    );
  }
}
