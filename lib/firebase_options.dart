import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) throw UnsupportedError('Web not supported');
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCz9OPW7YK4E0bpipeBAURsHAWKf6fxRFg',
    appId: '1:129847328496:android:1056ca85aca192934ccc35',
    messagingSenderId: '129847328496',
    projectId: 'ween-fe7f8',
    storageBucket: 'ween-fe7f8.firebasestorage.app',
  );
}