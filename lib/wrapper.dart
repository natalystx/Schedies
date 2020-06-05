import 'package:flutter/material.dart';
import 'package:schedule_app/model/User.dart';
import 'package:schedule_app/screens/welcome.dart';
import 'package:schedule_app/screens/overview.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return WelcomeScreen();
    } else {
      return OverviewScreen(
        uid: user.uid,
      );
    }
  }
}
