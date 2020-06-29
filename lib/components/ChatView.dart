import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/model/User.dart';

class ChatView extends StatefulWidget {
  final DocumentSnapshot receiver;
  final String chatID;
  ChatView({this.chatID, this.receiver});
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final textController = TextEditingController();
  String message;

  clearText() {
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 55,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Color.fromRGBO(85, 85, 85, .30),
                width: 1,
              )),
            ),
            child: Text(
              widget.receiver.data['name'],
              style: TextStyle(
                fontFamily: 'Mitr',
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(85, 85, 85, 1),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.height / 2.3,
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('Chat')
                    .document(widget.chatID)
                    .collection(widget.chatID)
                    .orderBy('createdTime', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Padding(padding: EdgeInsets.all(0));

                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    itemBuilder: (context, index) => Column(
                      children: <Widget>[
                        snapshot.data.documents[index]['sender'] ==
                                widget.receiver.documentID
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        widget.receiver.data['imageProfile']),
                                    radius: 25,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 10),
                                    child: Container(
                                      width: 240,
                                      margin: EdgeInsets.only(top: 50),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(250, 137, 123, 1),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          snapshot.data.documents[index]
                                              ['message'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Mitr',
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Padding(padding: EdgeInsets.all(0)),
                        snapshot.data.documents[index]['sender'] == user.uid
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 10),
                                    child: Container(
                                      width: 240,
                                      margin: EdgeInsets.only(top: 20),
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(62, 230, 192, 1),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          snapshot.data.documents[index]
                                              ['message'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Mitr',
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Padding(padding: EdgeInsets.all(0)),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: TextFormField(
              controller: textController,
              validator: (value) =>
                  value.isNotEmpty ? null : 'Please enter your massage.',
              onChanged: (value) => {
                setState(() {
                  message = value;
                })
              },
              obscureText: false,
              decoration: new InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (message.isNotEmpty) {
                      Firestore.instance
                          .collection('Chat')
                          .document(widget.chatID)
                          .collection(widget.chatID)
                          .add({
                        'sender': user.uid,
                        'receiver': widget.receiver.documentID,
                        'message': message,
                        'createdTime': DateTime.now().toIso8601String()
                      });
                      setState(() {
                        message = '';
                        clearText();
                      });
                    }
                  },
                  child: Icon(
                    Icons.send,
                    color: Color.fromRGBO(85, 85, 85, 1),
                    size: 24.0,
                  ),
                ),
                labelText: 'Type your massage.',
                labelStyle: new TextStyle(
                    fontFamily: "Mitr",
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                    color: Colors.black87),
                fillColor: Color.fromRGBO(255, 255, 255, 1),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.black54)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.black54)),
                filled: true,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  borderSide: new BorderSide(color: Colors.black54),
                ),
              ),
              keyboardType: TextInputType.text,
              style: new TextStyle(
                  fontFamily: "Mitr",
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  color: Colors.black87),
            ),
          )
        ],
      ),
    );
  }
}
