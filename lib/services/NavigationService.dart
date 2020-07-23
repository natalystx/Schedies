import 'package:flutter/material.dart';

class NavigationService {
  String docid;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName, String docId) {
    docid = docId;
    return navigatorKey.currentState.pushNamed(routeName);
  }
}
