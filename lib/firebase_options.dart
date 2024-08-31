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
    apiKey: 'AIzaSyAgDjL3HwB1yF373Mpyypa7s2A2NDaAu2Y',
    appId: '1:77385796256:web:58ca4a9fd755ee48ff57c5',
    messagingSenderId: '77385796256',
    projectId: 'flutterloginapp-6126f',
    authDomain: 'flutterloginapp-6126f.firebaseapp.com',
    storageBucket: 'flutterloginapp-6126f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHXNyID0U1yRFo1UHB_Bs2TLUho5tqoNI',
    appId: '1:77385796256:android:74fb3e309e802507ff57c5',
    messagingSenderId: '77385796256',
    projectId: 'flutterloginapp-6126f',
    storageBucket: 'flutterloginapp-6126f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBT9T8KyA0Mz28-Jukk1JVVFqx4ostV1EY',
    appId: '1:77385796256:ios:db2e56c6b6c2ea08ff57c5',
    messagingSenderId: '77385796256',
    projectId: 'flutterloginapp-6126f',
    storageBucket: 'flutterloginapp-6126f.appspot.com',
    iosBundleId: 'com.example.loginApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBT9T8KyA0Mz28-Jukk1JVVFqx4ostV1EY',
    appId: '1:77385796256:ios:db2e56c6b6c2ea08ff57c5',
    messagingSenderId: '77385796256',
    projectId: 'flutterloginapp-6126f',
    storageBucket: 'flutterloginapp-6126f.appspot.com',
    iosBundleId: 'com.example.loginApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAgDjL3HwB1yF373Mpyypa7s2A2NDaAu2Y',
    appId: '1:77385796256:web:c3a7f8e71a68106aff57c5',
    messagingSenderId: '77385796256',
    projectId: 'flutterloginapp-6126f',
    authDomain: 'flutterloginapp-6126f.firebaseapp.com',
    storageBucket: 'flutterloginapp-6126f.appspot.com',
  );
}