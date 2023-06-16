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
    apiKey: 'AIzaSyAue9R4ZOiz8SW1MFAu9ha0w7FUfhvFNuo',
    appId: '1:863151226507:web:52494443ae2ce899d75e8e',
    messagingSenderId: '863151226507',
    projectId: 'project-mini-gecw',
    authDomain: 'project-mini-gecw.firebaseapp.com',
    storageBucket: 'project-mini-gecw.appspot.com',
    measurementId: 'G-L4QDN6LKFM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB35v90XyUeQJRyBwCCZrWC5UGvWxMJRj4',
    appId: '1:863151226507:android:9a50bcc33f09cf2dd75e8e',
    messagingSenderId: '863151226507',
    projectId: 'project-mini-gecw',
    storageBucket: 'project-mini-gecw.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtUjOmikdro4UvSnLXeZpHtf1oEuBrnn0',
    appId: '1:863151226507:ios:546e56e76b86b0e1d75e8e',
    messagingSenderId: '863151226507',
    projectId: 'project-mini-gecw',
    storageBucket: 'project-mini-gecw.appspot.com',
    iosClientId: '863151226507-v2s5sou885sgpkp61aehiikph4c2phje.apps.googleusercontent.com',
    iosBundleId: 'com.example.mTrackn',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtUjOmikdro4UvSnLXeZpHtf1oEuBrnn0',
    appId: '1:863151226507:ios:636f6f8c33c1189fd75e8e',
    messagingSenderId: '863151226507',
    projectId: 'project-mini-gecw',
    storageBucket: 'project-mini-gecw.appspot.com',
    iosClientId: '863151226507-h02ggv4q8p768e54rauim0mkmk9q5e5d.apps.googleusercontent.com',
    iosBundleId: 'com.example.mTrackn.RunnerTests',
  );
}
