import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_firebase/utiles/utiles.dart';
import 'package:learn_firebase/widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  bool loading = false;
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');
  Future getimageGallary() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                getimageGallary();
              },
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: _image != null
                    ? Image.file(
                        _image!.absolute,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.image,
                        size: 50,
                      ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: RoundButton(
                  title: 'Upload',
                  loading: loading,
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('/Folder' + '112233');
                    firebase_storage.UploadTask uploadTask =
                        ref.putFile(_image!.absolute);
                    await Future.value(uploadTask);
                    var newUrl = await ref.getDownloadURL();
                    databaseRef
                        .child('12')
                        .set({
                          'desc': 'asif',
                          'title  ': newUrl.toString(),
                        })
                        .then((value) => {
                              setState(() {
                                loading = false;
                              }),
                              utils().toastmassage('Image Uploaded')
                            })
                        .onError((error, stackTrace) => {
                              setState(() {
                                loading = false;
                              })
                            });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
