import 'package:flutter/material.dart';
import 'package:schedule_app/services/AuthService.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          onPressed: () async => {await _auth.signOut()},
          child: Text('Sign out')),
    );
  }
}
