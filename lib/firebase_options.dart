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
    apiKey: 'AIzaSyD-fIskwhPiF9KRpGu3-z-P_dNkIBj-VBk',
    appId: '1:919432796323:web:dd41c3c640088536d94716',
    messagingSenderId: '919432796323',
    projectId: 'flutter-pizzeria',
    authDomain: 'flutter-pizzeria.firebaseapp.com',
    storageBucket: 'flutter-pizzeria.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAOGIM0Xql1n370k9fO2qOm_9rBlG0wMQ',
    appId: '1:919432796323:android:e79a931cbaa1c00fd94716',
    messagingSenderId: '919432796323',
    projectId: 'flutter-pizzeria',
    storageBucket: 'flutter-pizzeria.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2r1QaHf39uRuY8tMtY3PLdC0TkLZAyR0',
    appId: '1:919432796323:ios:938be53ada49d7bad94716',
    messagingSenderId: '919432796323',
    projectId: 'flutter-pizzeria',
    storageBucket: 'flutter-pizzeria.appspot.com',
    iosClientId: '919432796323-t4b1hucmgetccsb2snff7bov3m03nrea.apps.googleusercontent.com',
    iosBundleId: 'com.example.appPizzeria',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2r1QaHf39uRuY8tMtY3PLdC0TkLZAyR0',
    appId: '1:919432796323:ios:938be53ada49d7bad94716',
    messagingSenderId: '919432796323',
    projectId: 'flutter-pizzeria',
    storageBucket: 'flutter-pizzeria.appspot.com',
    iosClientId: '919432796323-t4b1hucmgetccsb2snff7bov3m03nrea.apps.googleusercontent.com',
    iosBundleId: 'com.example.appPizzeria',
  );
}
