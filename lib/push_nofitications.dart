import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app/services/NavigationService.dart';
import 'package:get_it/get_it.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  String token;
  final GetIt locator = GetIt.instance;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
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
    FirebaseMessaging().configure(
      onMessage: (message) async {
        print(message);
      },
      onResume: (message) async {
        print(message);
        locator<NavigationService>()
            .navigateTo(message['data']['screen'], message['data']['docid']);
      },
      onLaunch: (message) async {
        print(message);
        locator<NavigationService>()
            .navigateTo(message['data']['screen'], message['data']['docid']);
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
