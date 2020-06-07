import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/screens/myProfile.dart';

class ProfileList extends StatelessWidget {
  final BuildContext _context;
  final DocumentSnapshot _document;
  String _documentID;
  ProfileList(this._context, this._document, this._documentID);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyProfileScreen(_documentID)),
        );
      },
      child: ListTile(
          title: Card(
        color: Color.fromRGBO(222, 222, 222, 0),
        elevation: 0,
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    minRadius: 30,
                    maxRadius: 30,
                    backgroundImage:
                        NetworkImage(_document.data['imageProfile']),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          _document.data['name'].toString(),
                          style: TextStyle(
                            fontFamily: 'Mitr',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(126, 119, 119, 1),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              _document.data['userStatus'].toString(),
                              style: TextStyle(
                                fontFamily: 'Mitr',
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(126, 119, 119, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
    ;
  }
}
