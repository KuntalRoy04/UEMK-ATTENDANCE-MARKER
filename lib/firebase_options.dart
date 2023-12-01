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
    apiKey: 'AIzaSyCjq3bW8_0tjhK8hcc6SKCd5pU6-V5w8_Y',
    appId: '1:530327886604:web:fdaf32145ef2709e7cc729',
    messagingSenderId: '530327886604',
    projectId: 'uemkolkata',
    authDomain: 'uemkolkata.firebaseapp.com',
    storageBucket: 'uemkolkata.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUaFvr7k8DH4BOVL5ad3aDF_wvlfPPkDc',
    appId: '1:530327886604:android:297903f8ea4860c67cc729',
    messagingSenderId: '530327886604',
    projectId: 'uemkolkata',
    storageBucket: 'uemkolkata.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8CVkZ81h3QdMH--DMaD-AuYCeH8rXk0g',
    appId: '1:530327886604:ios:54b2c372207426e77cc729',
    messagingSenderId: '530327886604',
    projectId: 'uemkolkata',
    storageBucket: 'uemkolkata.appspot.com',
    iosBundleId: 'com.example.uemk',
  );
}