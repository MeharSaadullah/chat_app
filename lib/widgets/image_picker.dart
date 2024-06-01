import 'package:chat_app/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  var imageUrl;
  File? _pickedImageFile;
  final id = DateTime.now().microsecondsSinceEpoch;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final postRef = FirebaseDatabase.instance.ref().child('Posts');
  FirebaseStorage storage = FirebaseStorage.instance;

  // firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage
  //     .instance; // this code is for intilizing storage for upload of image.

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return Utils.flushBarErrorMessage('Kindly Sign in ', context);
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    final storageRef =
        storage.ref().child('images/${DateTime.now().toIso8601String()}.jpg');

    // Ensure _pickedImageFile is not null
    if (_pickedImageFile != null) {
      await storageRef.putFile(_pickedImageFile!);

      imageUrl = await storageRef.getDownloadURL();
      print(imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            foregroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
          ),
          TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(
              Icons.image,
              color: Color.fromARGB(160, 18, 130, 145),
            ),
            label: Text(
              'Add Image',
              style: TextStyle(
                color: Color.fromARGB(160, 18, 130, 145),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImagePickerWidget(),
  ));
}
