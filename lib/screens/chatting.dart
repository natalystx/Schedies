import 'package:flutter/material.dart';
import 'package:schedule_app/components/ChatView.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/model/User.dart';
import 'package:provider/provider.dart';

class ChattingScreen extends StatefulWidget {
  final bool isShowChat;
  final String chatID;
  final DocumentSnapshot receiver;
  ChattingScreen({this.chatID, this.isShowChat = false, this.receiver});
  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  bool isShowChat = false;
  DocumentSnapshot receiver;
  String chatID;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(255, 221, 148, 1),
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            Positioned(
              right: MediaQuery.of(context).size.width - 85,
              top: 20,
              child: TopOverlayBar(
                isShowBackButton: true,
                isShowRightIcon: false,
              ),
            ),
            Positioned(
              top: 95,
              left: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      'Chat',
                      style: TextStyle(
                        fontFamily: 'Mitr',
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  /// users list view
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 110,
                    padding: EdgeInsets.only(top: 10),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('Users data')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Padding(
                              padding: EdgeInsets.all(0),
                            );
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (user.uid.hashCode <=
                                          snapshot.data.documents[index]
                                              .documentID.hashCode) {
                                        chatID =
                                            '${user.uid}-${snapshot.data.documents[index].documentID}';
                                      } else {
                                        chatID =
                                            '${snapshot.data.documents[index].documentID}-${user.uid}';
                                      }
                                      Firestore.instance
                                          .collection('Chat')
                                          .document(chatID)
                                          .setData({
                                        'lastCheck':
                                            DateTime.now().toIso8601String()
                                      }, merge: true);

                                      receiver = snapshot.data.documents[index];
                                      isShowChat = true;
                                    });
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 32.5,
                                        backgroundImage: NetworkImage(snapshot
                                            .data
                                            .documents[index]['imageProfile']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data.documents[index]
                                              ['name'],
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(85, 85, 85, .95),
                                            fontFamily: 'Mitr',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: isShowChat || widget.isShowChat
                  ? ChatView(
                      chatID: chatID != null ? chatID : widget.chatID,
                      receiver: receiver != null ? receiver : widget.receiver)
                  : Padding(padding: EdgeInsets.all(0)),
            ),
          ],
        )),
      ),
    );
  }
}
