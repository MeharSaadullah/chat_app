// for storage on storage from fire base console and add firebase_storage dependenci
// flutter fireconfig to attach with firebase
import 'package:chat_app/Screens/HomeScreen.dart';
import 'package:chat_app/Screens/Login_screen.dart';
import 'package:chat_app/Screens/Screen_1.dart';
import 'package:chat_app/Screens/Signup_screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 84, 79, 94)),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            }
            return //LogInScreen();
                //SignUpScreen();
                ScreenOne();
          },
        )); //
  }
}
