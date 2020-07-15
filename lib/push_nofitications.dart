import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:schedule_app/screens/overview.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  String token;
  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }

    _firebaseMessaging.configure(
      onMessage: (message) async {
        print(message);
      },
      onResume: (message) async {
        print(message);
      },
      onLaunch: (message) async {
        print(message);
      },
    );
  }

  saveToken(String uid) async {
    token = await _firebaseMessaging.getToken();
    Firestore.instance
        .collection('Users data')
        .document(uid)
        .updateData({'fcmToken': token});
  }
}
