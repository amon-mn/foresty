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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCDll66xmGhwbYBFRRBxj8lvQIFrwXydqw',
    appId: '1:883889030916:web:1a9ce44e058b39d7fa7251',
    messagingSenderId: '883889030916',
    projectId: 'forest-traceability',
    authDomain: 'forest-traceability.firebaseapp.com',
    storageBucket: 'forest-traceability.appspot.com',
    measurementId: 'G-3Q760CMJBM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1WLHtdFen8QLgF2X4vMC_UVGXP2E-R3Q',
    appId: '1:883889030916:android:9abdf031b737127cfa7251',
    messagingSenderId: '883889030916',
    projectId: 'forest-traceability',
    storageBucket: 'forest-traceability.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBimLd-D8WjBEOo8DTjs7JIKOtYbxiHo-0',
    appId: '1:883889030916:ios:e904fbd95825ded6fa7251',
    messagingSenderId: '883889030916',
    projectId: 'forest-traceability',
    storageBucket: 'forest-traceability.appspot.com',
    androidClientId: '883889030916-2h22jrchemmmktr40fjd327nd78fei5o.apps.googleusercontent.com',
    iosClientId: '883889030916-rhrg32gli7kh20efa6lmn8s1goe71kkg.apps.googleusercontent.com',
    iosBundleId: 'com.example.foresty',
  );

}