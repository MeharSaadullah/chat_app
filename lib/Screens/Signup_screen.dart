import 'package:chat_app/Components/Round_Button.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Screens/Login_screen.dart';
import 'package:chat_app/Utils/utils.dart';
import 'package:chat_app/widgets/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  // final postRef = FirebaseDatabase.instance.ref().child('Posts');
  var imageUrl;

  File? _pickedImageFile;
  final picker = ImagePicker();
  final id = DateTime.now().millisecondsSinceEpoch;

  Future _pickImage() async {
    final storage = FirebaseStorage.instance;
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage == null) {
      return Utils.flushBarErrorMessage('No image selected', context);
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    // final storageRef =
    //     storage.ref().child('images/${DateTime.now().toIso8601String()}.jpg');

    if (pickedImage != null) {
      _pickedImageFile = File(pickedImage.path);
      final storageref = storage.ref('/ChatApp$id');
      UploadTask uploadTask = storageref.putFile(_pickedImageFile!.absolute);
      await Future.value(uploadTask);
      imageUrl = await storageref.getDownloadURL();

      setState(() {});
    }

    // if (_pickedImageFile != null) {
    //   await storageRef.putFile(_pickedImageFile!);

    //   imageUrl = await storageRef.getDownloadURL();
    //   print(imageUrl);
    // }
  }

  ValueNotifier<bool> _obsecurepassword = ValueNotifier<bool>(true);
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('user data');

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    phonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'SignUp',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        )),
        toolbarHeight: 100.0,
        flexibleSpace: Stack(
          children: [
            Image(image: AssetImage('assets/Rectangle 10.png')),
            Image(image: AssetImage('assets/Rectangle 11.png')),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.08,
              child: Image(image: AssetImage('assets/Rectangle 12.png')),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.60,
                left: MediaQuery.of(context).size.height * 0.13),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  foregroundImage: _pickedImageFile != null
                      ? FileImage(_pickedImageFile!)
                      : null,
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: _pickImage,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        color: Color.fromARGB(160, 18, 130, 145),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Add Image',
                        style: TextStyle(
                          color: Color.fromARGB(160, 18, 130, 145),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.55),
            child: Image(
                image: AssetImage('assets/young man with laptop on chair.png')),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(85, 39, 35, 35), width: 3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'mehar@gmail.com',
                        helperText: 'Enter e-mail',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter e-mail';
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phonecontroller,
                      obscureText: false,
                      decoration: InputDecoration(
                          labelText: 'Phone no',
                          hintText: 'phone',
                          helperText: 'Enter your phone number',
                          prefixIcon: Icon(Icons.phone),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5.0)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter phone number';
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'password',
                          suffixIcon: ValueListenableBuilder(
                            valueListenable: _obsecurepassword,
                            builder: (context, value, child) {
                              return InkWell(
                                onTap: () {
                                  _obsecurepassword.value =
                                      !_obsecurepassword.value;
                                },
                                child: Icon(
                                  value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility,
                                ),
                              );
                            },
                          ),
                          helperText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5.0)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                      },
                      obscureText: _obsecurepassword.value,
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text('Remember me?'),
                          Spacer(),
                          Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(160, 18, 130, 145),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    RoundButton(
                      text: 'Create An Account',
                      color: Color.fromARGB(160, 18, 130, 145),
                      onpress: () async {
                        try {
                          // Create user with email and password
                          await _auth.createUserWithEmailAndPassword(
                            email: emailcontroller.text.toString(),
                            password: passwordcontroller.text.toString(),
                          );

                          // Get the Firebase Messaging token
                          // String? token = await FirebaseMessaging.instance.getToken();

                          // Set user details in Firestore
                          // await firestore.doc(_auth.currentUser!.uid).set({
                          //   'email': emailcontroller.text.toString(),
                          //   'ppassword': passwordcontroller.text.toString(),
                          //   'phonenumber': phonecontroller.text.toString(),
                          //   'Userimage': imageUrl,
                          //   'id': _auth.currentUser!.uid,
                          //   //'token': token.toString(),
                          // });
                          await firestore.doc(_auth.currentUser!.uid).set({
                            'email': emailcontroller.text.toString(),
                            'password': passwordcontroller.text
                                .toString(), // Should be 'password' not 'ppassword'
                            'phonenumber': phonecontroller.text.toString(),
                            'Userimage':
                                imageUrl, // This line saves the image URL in Firestore
                            'id': _auth.currentUser!.uid,
                          });

                          // Show success message and navigate to HomeScreen
                          Utils.flushBarErrorMessage(
                              'Account Created', context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        } catch (error) {
                          // Handle any errors
                          Utils.flushBarErrorMessage(error.toString(), context);
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInScreen()));
                            },
                            child: Text(
                              'Log In ',
                              style: TextStyle(
                                color: Color.fromARGB(160, 18, 130, 145),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
