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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDYruxNSEKW0LUdSmwY2wNIPR4S1u5m65c',
    appId: '1:249891496822:web:0fefcd6e38606c58e99057',
    messagingSenderId: '249891496822',
    projectId: 'learn-firebase-project-61e20',
    authDomain: 'learn-firebase-project-61e20.firebaseapp.com',
    databaseURL: 'https://learn-firebase-project-61e20-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'learn-firebase-project-61e20.appspot.com',
    measurementId: 'G-KYCED3DWSL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAt-A3ComHfA7huzG5f3UnqrysWXo2ynPM',
    appId: '1:249891496822:android:72ae144e242e9b3ee99057',
    messagingSenderId: '249891496822',
    projectId: 'learn-firebase-project-61e20',
    databaseURL: 'https://learn-firebase-project-61e20-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'learn-firebase-project-61e20.appspot.com',

  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQyMO2nNyvsBbMGkfpYM3_6LOceNHyVgI',
    appId: '1:249891496822:ios:6067f076b9ad78d6e99057',
    messagingSenderId: '249891496822',
    projectId: 'learn-firebase-project-61e20',
    databaseURL: 'https://learn-firebase-project-61e20-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'learn-firebase-project-61e20.appspot.com',
    androidClientId: '249891496822-cmnq3kuf4385ggl3fr4esrmgltgbkq9u.apps.googleusercontent.com',
    iosClientId: '249891496822-teu2plghhs1girfhun4mhvbsr4d94mcd.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseProject',

  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQyMO2nNyvsBbMGkfpYM3_6LOceNHyVgI',
    appId: '1:249891496822:ios:6067f076b9ad78d6e99057',
    messagingSenderId: '249891496822',
    projectId: 'learn-firebase-project-61e20',
    databaseURL: 'https://learn-firebase-project-61e20-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'learn-firebase-project-61e20.appspot.com',
    androidClientId: '249891496822-cmnq3kuf4385ggl3fr4esrmgltgbkq9u.apps.googleusercontent.com',
    iosClientId: '249891496822-teu2plghhs1girfhun4mhvbsr4d94mcd.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDYruxNSEKW0LUdSmwY2wNIPR4S1u5m65c',
    appId: '1:249891496822:web:61a22ad6946e2b2be99057',
    messagingSenderId: '249891496822',
    projectId: 'learn-firebase-project-61e20',
    authDomain: 'learn-firebase-project-61e20.firebaseapp.com',
    databaseURL: 'https://learn-firebase-project-61e20-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'learn-firebase-project-61e20.appspot.com',
    measurementId: 'G-99PB4VMCRJ',
  );
}
