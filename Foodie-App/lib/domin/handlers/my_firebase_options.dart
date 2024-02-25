import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvbzi4Otmgjw37UZybZk6cgGKb1QeKsgw',
    appId: '1:732738074097:web:de58947609d53efc6fc050',
    messagingSenderId: '732738074097',
    projectId: 'goshops-7c405',
    // databaseURL: 'https://onlyu-live-default-rtdb.firebaseio.com',
    storageBucket: 'goshops-7c405.appspot.com',
    authDomain: 'goshops-7c405.firebaseapp.com',
    measurementId: 'G-SK0FJ6BCPH',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDudBWMn5armfoFLKwpgAjpM7LOyPEu5XU',
    appId: '1:732738074097:web:de58947609d53efc6fc050',
    messagingSenderId: '732738074097',
    projectId: 'goshops-7c405',
    // databaseURL: 'https://onlyu-live-default-rtdb.firebaseio.com',
    storageBucket: 'goshops-7c405.appspot.com',
    androidClientId:
        '732738074097-4f1op36ibs6481rc03321q89f5dp3krh.apps.googleusercontent.com',
    iosClientId:
        '732738074097-4f1op36ibs6481rc03321q89f5dp3krh.apps.googleusercontent.com',
    iosBundleId: 'org.goshops',
  );
}
