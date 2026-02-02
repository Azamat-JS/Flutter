import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web.',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByVGawDfiWVJRyRPUtDdYaSIUqmYWNYJw',
    appId: '1:144526956063:android:2c3a87848f98dc4bdca72a',
    messagingSenderId: '144526956063',
    projectId: 'authentication-9e15e',
    storageBucket: 'authentication-9e15e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUdFucEJrP8i87F9vSjrGE-rPNwrHFbTY',
    appId: '1:144526956063:ios:3637a4b27b16690adca72a',
    messagingSenderId: '144526956063',
    projectId: 'authentication-9e15e',
    storageBucket: 'authentication-9e15e.firebasestorage.app',
    iosBundleId: 'com.example.authenticatio',
  );
}
