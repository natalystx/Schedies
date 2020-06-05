import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventCardList extends StatelessWidget {
  final BuildContext _context;
  final DocumentSnapshot _document;

  EventCardList(this._context, this._document);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Card(
      color: Color.fromRGBO(222, 222, 222, 0),
      elevation: 0,
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  minRadius: 35,
                  maxRadius: 35,
                  backgroundImage: NetworkImage(
                      'https://www.lilianpacce.com.br/wp-content/uploads/2018/03/50318-vogue-marina-ruy-barbosa-02.jpg'),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        _document.data['topic'].toString(),
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
                            _document.data['inviteUser'].toString(),
                            style: TextStyle(
                              fontFamily: 'Mitr',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(126, 119, 119, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            _document.data['startTime'].toString() +
                                '-' +
                                _document.data['endTime'].toString(),
                            style: TextStyle(
                              fontFamily: 'Mitr',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(126, 119, 119, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              _document.data['details'].toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Mitr',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(126, 119, 119, 1),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'With ' + _document.data['moreInvite'].toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Mitr',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(126, 119, 119, 1),
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
          ],
        ),
      ),
    ));
  }
}
