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
    apiKey: 'AIzaSyBAGCMNd8xmgStTwCn5gqYNXo2_Tph81EY',
    appId: '1:207601474404:web:a265ffe713210592c57871',
    messagingSenderId: '207601474404',
    projectId: 'mynotes-prodata',
    authDomain: 'mynotes-prodata.firebaseapp.com',
    storageBucket: 'mynotes-prodata.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCd0HftGs4YqfPXkNwZDfahpwHDxNXI_MU',
    appId: '1:207601474404:android:f22ca60459a59050c57871',
    messagingSenderId: '207601474404',
    projectId: 'mynotes-prodata',
    storageBucket: 'mynotes-prodata.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWLxQ8kYrNtORmcO1g0ZyZop7rsGCHKkE',
    appId: '1:207601474404:ios:6e01e3a88093e778c57871',
    messagingSenderId: '207601474404',
    projectId: 'mynotes-prodata',
    storageBucket: 'mynotes-prodata.firebasestorage.app',
    iosBundleId: 'br.prodata.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWLxQ8kYrNtORmcO1g0ZyZop7rsGCHKkE',
    appId: '1:207601474404:ios:6e01e3a88093e778c57871',
    messagingSenderId: '207601474404',
    projectId: 'mynotes-prodata',
    storageBucket: 'mynotes-prodata.firebasestorage.app',
    iosBundleId: 'br.prodata.mynotes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBAGCMNd8xmgStTwCn5gqYNXo2_Tph81EY',
    appId: '1:207601474404:web:5206e177b82bbea1c57871',
    messagingSenderId: '207601474404',
    projectId: 'mynotes-prodata',
    authDomain: 'mynotes-prodata.firebaseapp.com',
    storageBucket: 'mynotes-prodata.firebasestorage.app',
  );
}
