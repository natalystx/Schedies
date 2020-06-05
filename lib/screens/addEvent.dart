import 'package:flutter/material.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:schedule_app/components/WelcomeText.dart';
import 'package:schedule_app/services/CloudDataService.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
  final DateTime _date;
  final String _uid;
  AddEventScreen(this._date, this._uid);
}

class _AddEventScreenState extends State<AddEventScreen> {
  final CloudDataService firestore = CloudDataService();
  String _inviteUser;
  String _startTime;
  String _endTime;
  String _topic;
  String _details;
  String _moreInvite;
  List<String> _moreInviteList;
  String _location;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Center(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 50,
                    right: 20,
                    child: TopOverlayBar(
                      isShowBackButton: true,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 100),
                        child: Image(
                          image: AssetImage('assets/images/5264.png'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          WelcomeText(
                            25,
                            FontWeight.w400,
                            'Make an appointment',
                            paddingSide: EdgeInsets.only(top: 20),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          WelcomeText(
                            15,
                            FontWeight.w300,
                            'Let’s do some events.',
                            paddingSide: EdgeInsets.only(bottom: 40),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 20, left: 15),
                            width: 50,
                            child: Text(
                              'At',
                              style: TextStyle(
                                fontFamily: 'Mitr',
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(85, 85, 85, 1),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            width: 300,
                            child: Text(
                              widget._date
                                  .toLocal()
                                  .toIso8601String()
                                  .substring(0, 10),
                              style: TextStyle(
                                fontFamily: 'Mitr',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(85, 85, 85, 1),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 20, left: 15),
                            width: 50,
                            child: Text(
                              'With',
                              style: TextStyle(
                                fontFamily: 'Mitr',
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(85, 85, 85, 1),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20, left: 10),
                            width: 300,
                            child: Text(
                              'Nayyhhh hhhhh',
                              style: TextStyle(
                                fontFamily: 'Mitr',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(85, 85, 85, 1),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 350,
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onChanged: (value) =>
                                  {setState(() => _startTime = value)},
                              obscureText: false,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                labelText: 'Start time',
                                labelStyle: new TextStyle(
                                    fontFamily: "Mitr",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                                fillColor: Color.fromRGBO(62, 230, 192, 1),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                filled: true,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                              style: new TextStyle(
                                  fontFamily: "Mitr",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 350,
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onChanged: (value) =>
                                  {setState(() => _endTime = value)},
                              obscureText: false,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.alarm_off,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                labelText: 'End time',
                                labelStyle: new TextStyle(
                                    fontFamily: "Mitr",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                                fillColor: Color.fromRGBO(250, 137, 123, 1),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                filled: true,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                              style: new TextStyle(
                                  fontFamily: "Mitr",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 350,
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onChanged: (value) =>
                                  {setState(() => _topic = value)},
                              obscureText: false,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.dvr,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                labelText: 'Topic',
                                labelStyle: new TextStyle(
                                    fontFamily: "Mitr",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                                fillColor: Color.fromRGBO(208, 230, 165, 1),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                filled: true,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                  fontFamily: "Mitr",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 350,
                            margin: EdgeInsets.only(bottom: 20),
                            child: new TextFormField(
                              onChanged: (value) =>
                                  {setState(() => _details = value)},
                              obscureText: false,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.library_books,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                labelText: 'Details',
                                labelStyle: new TextStyle(
                                    fontFamily: "Mitr",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                                fillColor: Color.fromRGBO(255, 221, 138, 1),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                filled: true,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: new TextStyle(
                                  fontFamily: "Mitr",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 350,
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onChanged: (value) =>
                                  {setState(() => _location = value)},
                              obscureText: false,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                labelText: 'Location',
                                labelStyle: new TextStyle(
                                    fontFamily: "Mitr",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                                fillColor: Color.fromRGBO(134, 152, 227, 1),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                filled: true,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                  fontFamily: "Mitr",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 350,
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              onChanged: (value) => {
                                setState(() => _moreInvite = value),
                                _moreInviteList = _moreInvite.split(','),
                              },
                              obscureText: false,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.people_outline,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                labelText: 'More invite people (Optional)',
                                labelStyle: new TextStyle(
                                    fontFamily: "Mitr",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                                fillColor: Color.fromRGBO(134, 220, 227, 1),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                filled: true,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                  fontFamily: "Mitr",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 50),
                            child: ButtonTheme(
                              minWidth: 350,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () async => {
                                  await firestore.addEventData(
                                    widget._uid,
                                    widget._date.toIso8601String(),
                                    _topic,
                                    _details,
                                    _inviteUser,
                                    _startTime,
                                    _endTime,
                                    _location,
                                    moreInvite: _moreInviteList,
                                  )
                                },
                                color: Color.fromRGBO(255, 221, 148, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 24,
                                      height: 24,
                                      margin: EdgeInsets.only(right: 10),
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/fastclock.png'),
                                      ),
                                    ),
                                    Text(
                                      'Make an appointment',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
