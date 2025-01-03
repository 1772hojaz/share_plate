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
    apiKey: 'AIzaSyChW5FO3T7hWC4XNhqwu4g1KFpzfz9BZvE',
    appId: '1:253761949733:web:283ca17620e90787052fcc',
    messagingSenderId: '253761949733',
    projectId: 'shareplate-4c505',
    authDomain: 'shareplate-4c505.firebaseapp.com',
    storageBucket: 'shareplate-4c505.firebasestorage.app',
    measurementId: 'G-XQ3NQLM04X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAh0vBcb3omfT-HUOuPbSCzlxuE7ZisxsY',
    appId: '1:253761949733:android:5b5f15eae96f47a6052fcc',
    messagingSenderId: '253761949733',
    projectId: 'shareplate-4c505',
    storageBucket: 'shareplate-4c505.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmMDZi47T2m2Yv1p7jLqMcBDoYd3UdNuI',
    appId: '1:253761949733:ios:f8cf5099f0c62c78052fcc',
    messagingSenderId: '253761949733',
    projectId: 'shareplate-4c505',
    storageBucket: 'shareplate-4c505.firebasestorage.app',
    androidClientId:
        '253761949733-66e9p7iav4esrj7ff20p0ian9nmfq97k.apps.googleusercontent.com',
    iosClientId:
        '253761949733-mal5kiup9287jvmhnhfu714ifu1frt3h.apps.googleusercontent.com',
    iosBundleId: 'com.example.sharePlate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmMDZi47T2m2Yv1p7jLqMcBDoYd3UdNuI',
    appId: '1:253761949733:ios:f8cf5099f0c62c78052fcc',
    messagingSenderId: '253761949733',
    projectId: 'shareplate-4c505',
    storageBucket: 'shareplate-4c505.firebasestorage.app',
    androidClientId:
        '253761949733-66e9p7iav4esrj7ff20p0ian9nmfq97k.apps.googleusercontent.com',
    iosClientId:
        '253761949733-mal5kiup9287jvmhnhfu714ifu1frt3h.apps.googleusercontent.com',
    iosBundleId: 'com.example.sharePlate',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyChW5FO3T7hWC4XNhqwu4g1KFpzfz9BZvE',
    appId: '1:253761949733:web:44bac8d2493076ba052fcc',
    messagingSenderId: '253761949733',
    projectId: 'shareplate-4c505',
    authDomain: 'shareplate-4c505.firebaseapp.com',
    storageBucket: 'shareplate-4c505.firebasestorage.app',
    measurementId: 'G-1R0JHWR765',
  );
}
