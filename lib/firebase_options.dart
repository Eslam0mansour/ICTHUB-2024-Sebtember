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
    apiKey: 'AIzaSyCqjhWBJxj3kW1CzK15uZs4bV3CLW6F9eE',
    appId: '1:681420713136:web:10b600af37cabfeb751f75',
    messagingSenderId: '681420713136',
    projectId: 'icthub2024-9',
    authDomain: 'icthub2024-9.firebaseapp.com',
    storageBucket: 'icthub2024-9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSUUQk-K_C9EcZDrCp3NmPvo3reGHG8XM',
    appId: '1:681420713136:android:57e7b3ef909de647751f75',
    messagingSenderId: '681420713136',
    projectId: 'icthub2024-9',
    storageBucket: 'icthub2024-9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzQR1Syzwvs6p62mfadfO7oU9cX1AuiIU',
    appId: '1:681420713136:ios:d37e1a8c24260aac751f75',
    messagingSenderId: '681420713136',
    projectId: 'icthub2024-9',
    storageBucket: 'icthub2024-9.appspot.com',
    iosBundleId: 'com.example.icthub20249',
  );
}
