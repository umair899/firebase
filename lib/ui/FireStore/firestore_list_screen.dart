import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:learn_firebase/ui/FireStore/addfirestore.dart';
import 'package:learn_firebase/utiles/utiles.dart';
import 'package:learn_firebase/widgets/round_button.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireStore'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: fireStore,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();

                  if (snapshot.hasError) return Text("Some Error");

                  return Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        onTap: (() {
                          ref
                              .doc(snapshot.data!.docs[index]['id'].toString())
                              .update({
                            'title': 'I am not good in flutter '
                          }).then((value) {
                            utils().toastmassage('Update');
                          }).onError((error, stackTrace) {
                            utils().toastmassage(error.toString());
                          });
                          // ref
                          //     .doc(snapshot.data!.docs[index]['id'].toString())
                          //     .delete();
                        }),
                        title: Text(
                            snapshot.data!.docs[index]['title'].toString()),
                        subtitle:
                            Text(snapshot.data!.docs[index]['id'].toString()),
                      );
                    }),
                  ));
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const AddPostScreen())));
        }),
      ),
    );
  }
}
