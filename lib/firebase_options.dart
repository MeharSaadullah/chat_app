// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCnL7vpMobaN4kuKap5BqShJVZweB2524Y',
    appId: '1:693638692471:web:98dbbc98613d6237465072',
    messagingSenderId: '693638692471',
    projectId: 'chatapp-3a270',
    authDomain: 'chatapp-3a270.firebaseapp.com',
    storageBucket: 'chatapp-3a270.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtgFSuOXyOXoaEG4rHFhNVsfTO5ViSv6g',
    appId: '1:693638692471:android:7fd419ac6c7ffeca465072',
    messagingSenderId: '693638692471',
    projectId: 'chatapp-3a270',
    storageBucket: 'chatapp-3a270.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHSUsrdkQnvUSybn02kIOs6yEEVHEaZy0',
    appId: '1:693638692471:ios:d050da81de49af09465072',
    messagingSenderId: '693638692471',
    projectId: 'chatapp-3a270',
    storageBucket: 'chatapp-3a270.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHSUsrdkQnvUSybn02kIOs6yEEVHEaZy0',
    appId: '1:693638692471:ios:bb41e23af5bfc82d465072',
    messagingSenderId: '693638692471',
    projectId: 'chatapp-3a270',
    storageBucket: 'chatapp-3a270.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}
