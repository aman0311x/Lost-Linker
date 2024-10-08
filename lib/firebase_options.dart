
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
    apiKey: 'AIzaSyDleoniIrNV2iNFq1hQbsj5ZJl3djJhhLU',
    appId: '1:844153587045:web:545a505d3afde075c54d8c',
    messagingSenderId: '844153587045',
    projectId: 'lostlinker-8b41e',
    authDomain: 'lostlinker-8b41e.firebaseapp.com',
    storageBucket: 'lostlinker-8b41e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB51VQNx_cbvT4-3HLzEyGwYF827kypGmI',
    appId: '1:844153587045:android:569916b750b077e1c54d8c',
    messagingSenderId: '844153587045',
    projectId: 'lostlinker-8b41e',
    storageBucket: 'lostlinker-8b41e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMDMlaRW6darUHI279cfrwoSUFzS-YEX8',
    appId: '1:844153587045:ios:56e256615f3b9575c54d8c',
    messagingSenderId: '844153587045',
    projectId: 'lostlinker-8b41e',
    storageBucket: 'lostlinker-8b41e.appspot.com',
    iosBundleId: 'com.example.lostlinker',
  );
}
