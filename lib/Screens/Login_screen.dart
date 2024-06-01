import 'package:chat_app/Components/Round_Button.dart';
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Screens/Signup_screen.dart';
import 'package:chat_app/Utils/Utils.dart';
import 'package:chat_app/widgets/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  ValueNotifier<bool> _obsecurepassword =
      ValueNotifier<bool>(true); // for visibility of password

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;

  var _isAuthanticating = false;

  @override
  void dispose() {
    // TODO: implement dispose
    // super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login() {
    _auth.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text.toString());

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));

    // Handle successful login if needed
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        )),
        toolbarHeight: 120.0,
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
                left: MediaQuery.of(context).size.width * 0.50,
                top: MediaQuery.of(context).size.height * 0.10),
            child: Image(
                image: AssetImage(
                    'assets/smiling young man with laptop sitting on floor.png')),
          ),
          SizedBox(
            height: 2,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(85, 39, 35, 35), width: 3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'mehar@gmail.com',
                        helperText: 'enter e-mail ',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter e-mail';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: passwordcontroller,
                      //   obscureText: true, // for password hide
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'password',
                          suffixIcon: InkWell(
                              onTap: () {
                                _obsecurepassword.value =
                                    !_obsecurepassword.value;
                              },
                              child: Icon(_obsecurepassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility)),
                          helperText: 'enter your passowrd',
                          prefixIcon: Icon(Icons.lock),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5.0)),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text('Remember me?'),
                          SizedBox(
                            width: 80,
                          ),
                          Text(
                            'Forget Pssword?',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(160, 18, 130, 145),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                   // if (_isAuthanticating) {CircularProgressIndicator},
                    if (!_isAuthanticating)
                      RoundButton(
                          text: 'Login',
                          color: Color.fromARGB(160, 18, 130, 145),
                          onpress: () {
                            _auth
                                .signInWithEmailAndPassword(
                                    email: emailcontroller.text.toString(),
                                    password:
                                        passwordcontroller.text.toString())
                                .then((value) => {
                                      
                                        Utils.flushBarErrorMessage(
                                            value.user!.email.toString(),
                                            context),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()))

                                      // Handle successful login if needed
                                    })
                                .catchError((error) {
                              Utils.flushBarErrorMessage(
                                  error.toString(), context);
                              setState(() {
                                _isAuthanticating = false;
                              });
                            });
                          }),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Dont have an account?'),
                        TextButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Text(
                              'Sign Up',
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
          )
        ],
      ),
    );
  }
}
