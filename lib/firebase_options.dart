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
    apiKey: 'AIzaSyCHvnJLvR_wJQJaAErmkLyJ0GaEdJ8cz5w',
    appId: '1:33296540073:web:ea8cf899b4d07cb80c64b8',
    messagingSenderId: '33296540073',
    projectId: 'flutter-task-55acd',
    authDomain: 'flutter-task-55acd.firebaseapp.com',
    storageBucket: 'flutter-task-55acd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCf669ufEbispAlebGfO1Xw-EuSUdcHPnU',
    appId: '1:33296540073:android:6bb0fcb26e2c737e0c64b8',
    messagingSenderId: '33296540073',
    projectId: 'flutter-task-55acd',
    storageBucket: 'flutter-task-55acd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5H4j_mDNgqZJobtQH5_XbNvBPFPv01X0',
    appId: '1:33296540073:ios:b8472c8d7e2b83830c64b8',
    messagingSenderId: '33296540073',
    projectId: 'flutter-task-55acd',
    storageBucket: 'flutter-task-55acd.appspot.com',
    iosClientId: '33296540073-u5da0p6ogsniumc7ndhqqcrbsl512uck.apps.googleusercontent.com',
    iosBundleId: 'com.example.taskApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5H4j_mDNgqZJobtQH5_XbNvBPFPv01X0',
    appId: '1:33296540073:ios:3a9129e5defbf3bf0c64b8',
    messagingSenderId: '33296540073',
    projectId: 'flutter-task-55acd',
    storageBucket: 'flutter-task-55acd.appspot.com',
    iosClientId: '33296540073-lddpfdspf1aderl8dv4fdoeut22nl8e7.apps.googleusercontent.com',
    iosBundleId: 'com.example.taskApp.RunnerTests',
  );
}