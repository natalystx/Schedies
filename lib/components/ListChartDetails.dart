import 'package:flutter/material.dart';

class ListChartDetails extends StatelessWidget {
  final Map<String, Color> colorStatus = {
    'Pending': Color.fromRGBO(255, 221, 148, 1),
    'Approved': Color.fromRGBO(62, 230, 192, 1),
    'Cancelled': Color.fromRGBO(250, 137, 123, 1),
    'Rejected': Color.fromRGBO(180, 175, 175, 1),
    'Completed': Color.fromRGBO(134, 152, 227, 1),
    'Be over': Color.fromRGBO(204, 171, 216, 1),
    'Questioning': Color.fromRGBO(255, 148, 230, 1),
  };
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 10.5,
              backgroundColor: colorStatus['Pending'],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Pending',
                style: TextStyle(
                  fontFamily: 'Mitr',
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 10.5,
              backgroundColor: colorStatus['Approved'],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Approved',
                style: TextStyle(
                  fontFamily: 'Mitr',
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 10.5,
              backgroundColor: colorStatus['Cancelled'],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Cancelled',
                style: TextStyle(
                  fontFamily: 'Mitr',
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 10.5,
              backgroundColor: colorStatus['Rejected'],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Rejected',
                style: TextStyle(
                  fontFamily: 'Mitr',
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 10.5,
              backgroundColor: colorStatus['Completed'],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Completed',
                style: TextStyle(
                  fontFamily: 'Mitr',
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 10.5,
              backgroundColor: colorStatus['Be over'],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Be over',
                style: TextStyle(
                  fontFamily: 'Mitr',
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
