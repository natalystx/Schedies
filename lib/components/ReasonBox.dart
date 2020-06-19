import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/components/EventDetailsTemplate.dart';
import 'package:schedule_app/wrapper.dart';

class ReasonBox extends StatefulWidget {
  DocumentSnapshot _document;

  ReasonBox(this._document);

  @override
  _ReasonBoxState createState() => _ReasonBoxState();
}

class _ReasonBoxState extends State<ReasonBox> {
  String _reason;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          color: Color.fromRGBO(250, 137, 123, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Give some reason.',
                      style: TextStyle(
                          fontFamily: 'Mitr',
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 100,
                    margin: EdgeInsets.only(top: 25, bottom: 0),
                    child: new TextFormField(
                      validator: (value) =>
                          value.isNotEmpty ? null : 'Please give some reason.',
                      onChanged: (value) => {setState(() => _reason = value)},
                      obscureText: false,
                      decoration: new InputDecoration(
                        prefixIcon: Icon(
                          Icons.library_books,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        labelText: 'Give some reason.',
                        labelStyle: new TextStyle(
                            fontFamily: "Mitr",
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                        fillColor: Color.fromRGBO(255, 211, 138, 1),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.white)),
                        filled: true,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(color: Colors.white),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width - 30,
                      height: 50,
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () => {
                          if (widget._document.data['eventStatus'] == 'Pending')
                            {
                              Firestore.instance
                                  .document(
                                      'Events/${widget._document.documentID}')
                                  .updateData({'eventStatus': 'Rejected'}),
                              Firestore.instance
                                  .document(
                                      'Events/${widget._document.documentID}')
                                  .updateData({'reason': _reason}),
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => new Wrapper(),
                                ),
                              )
                            }
                          else
                            {
                              Firestore.instance
                                  .document(
                                      'Events/${widget._document.documentID}')
                                  .updateData({'eventStatus': 'Cancelled'}),
                              Firestore.instance
                                  .document(
                                      'Events/${widget._document.documentID}')
                                  .updateData({'reason': _reason}),
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => new Wrapper(),
                                ),
                              )
                            }
                        },
                        color: Color.fromRGBO(255, 211, 138, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Give reason',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'Mitr',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
