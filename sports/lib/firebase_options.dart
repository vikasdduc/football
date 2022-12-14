// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4f3ryBfFDQQcj345-T4iivkHrOeUb5Qc',
    appId: '1:672216862978:android:259153bb87c6d67be1321b',
    messagingSenderId: '672216862978',
    projectId: 'apnateam-b7ddb',
    storageBucket: 'apnateam-b7ddb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjoJuHEfk-bRETwXwV-5Re1rGmVGiAWVA',
    appId: '1:672216862978:ios:de5c2554d5a7b51de1321b',
    messagingSenderId: '672216862978',
    projectId: 'apnateam-b7ddb',
    storageBucket: 'apnateam-b7ddb.appspot.com',
    iosClientId: '672216862978-ifal2nro2b4ql1hnd65ppn0i2br2j54l.apps.googleusercontent.com',
    iosBundleId: 'com.apnateam.app',
  );
}
