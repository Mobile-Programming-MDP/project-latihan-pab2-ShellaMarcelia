// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCDHphczUCEw9VS65izFsLpQ_oBxIQsjVY',
    appId: '1:960554348966:web:837c47aeaea52b3eb3df67',
    messagingSenderId: '960554348966',
    projectId: 'fasum-j-7157c',
    authDomain: 'fasum-j-7157c.firebaseapp.com',
    databaseURL: 'https://fasum-j-7157c-default-rtdb.firebaseio.com',
    storageBucket: 'fasum-j-7157c.firebasestorage.app',
    measurementId: 'G-F71HQEE24M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0FokpeBYIrXupPa1072V8ecic73alvDQ',
    appId: '1:960554348966:android:21592d16a4f07f3fb3df67',
    messagingSenderId: '960554348966',
    projectId: 'fasum-j-7157c',
    databaseURL: 'https://fasum-j-7157c-default-rtdb.firebaseio.com',
    storageBucket: 'fasum-j-7157c.firebasestorage.app',
  );
}
