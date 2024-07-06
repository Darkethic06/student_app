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
    apiKey: 'AIzaSyDKKHPYoSfagSxfB-snjIK79AJVlzHpVtA',
    appId: '1:630976598118:web:eebd3323000871a7e9dda7',
    messagingSenderId: '630976598118',
    projectId: 'north-point-school',
    authDomain: 'north-point-school.firebaseapp.com',
    storageBucket: 'north-point-school.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqdyoGLDNeb_pVTINhIBKvgHtWgNoI7C4',
    appId: '1:630976598118:ios:d2e6a8ffae7028fde9dda7',
    messagingSenderId: '630976598118',
    projectId: 'north-point-school',
    storageBucket: 'north-point-school.appspot.com',
    iosBundleId: 'in.truepid.northpoint',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqdyoGLDNeb_pVTINhIBKvgHtWgNoI7C4',
    appId: '1:630976598118:ios:a39e757eee7a832be9dda7',
    messagingSenderId: '630976598118',
    projectId: 'north-point-school',
    storageBucket: 'north-point-school.appspot.com',
    iosBundleId: '.studentapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDKKHPYoSfagSxfB-snjIK79AJVlzHpVtA',
    appId: '1:630976598118:web:ef99bad66efbfb81e9dda7',
    messagingSenderId: '630976598118',
    projectId: 'north-point-school',
    authDomain: 'north-point-school.firebaseapp.com',
    storageBucket: 'north-point-school.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3uxG6rXIYf5TWf-0N0APvuRdm8hhgxqY',
    appId: '1:630976598118:android:bb5de06d9308e2e2e9dda7',
    messagingSenderId: '630976598118',
    projectId: 'north-point-school',
    storageBucket: 'north-point-school.appspot.com',
  );

}