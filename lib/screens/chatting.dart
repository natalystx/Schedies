import 'package:flutter/material.dart';
import 'package:schedule_app/components/ChatView.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/model/User.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/services/AppLanguage.dart';
import 'package:schedule_app/services/AppLocalizations.dart';
import 'package:badges/badges.dart';

class ChattingScreen extends StatefulWidget {
  final bool isShowChat;
  final String chatID;
  final DocumentSnapshot receiver;
  final DocumentSnapshot sender;

  ChattingScreen(
      {this.chatID, this.isShowChat = false, this.receiver, this.sender});
  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  List<Map<String, dynamic>> isSeletedList = [];
  bool userSelected = false;
  bool isShowChat = false;
  int lastIndex = 0;
  DocumentSnapshot receiver;
  Map<String, dynamic> isRead = {};
  String chatID;
  DocumentSnapshot sender;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
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
            top: 85,
            left: 35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Text(
                    AppLocalizations.of(context).translate('chat'),
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
                  height: 130,
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

                        snapshot.data.documents.forEach((doc) {
                          isSeletedList.add({'isSelected': false});
                          if (doc.documentID == user.uid) {
                            sender = doc;
                          }
                        });
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
                                    isSeletedList[lastIndex]['isSelected'] =
                                        false;
                                    isSeletedList[index]['isSelected'] = true;
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
                                    lastIndex = index;
                                  });
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: isSeletedList[index]
                                                      ['isSelected']
                                                  ? Color.fromRGBO(
                                                      62, 230, 192, 1)
                                                  : Color.fromRGBO(
                                                      255, 202, 148, 1),
                                              width: 2)),
                                      child: isRead[snapshot
                                                  .data
                                                  .documents[index]
                                                  .documentID] !=
                                              null
                                          ? Badge(
                                              child: CircleAvatar(
                                                radius: 32.5,
                                                backgroundImage: NetworkImage(
                                                    snapshot.data
                                                            .documents[index]
                                                        ['imageProfile']),
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 32.5,
                                              backgroundImage: NetworkImage(
                                                  snapshot.data.documents[index]
                                                      ['imageProfile']),
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data.documents[index]['name'],
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
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: isShowChat || widget.isShowChat
                ? ChatView(
                    chatID: chatID != null ? chatID : widget.chatID,
                    receiver: receiver != null ? receiver : widget.receiver,
                    sender: sender != null ? sender : widget.sender,
                  )
                : Padding(padding: EdgeInsets.all(0)),
          ),
        ],
      )),
    );
  }
}
