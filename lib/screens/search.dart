import 'package:flutter/material.dart';
import 'package:schedule_app/components/BottomMenuBar.dart';
import 'package:schedule_app/components/ProfileList.dart';
import 'package:schedule_app/components/TopOverlayBar.dart';
import 'package:schedule_app/components/WelcomeText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/services/AppLanguage.dart';
import 'package:schedule_app/services/AppLocalizations.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 125),
                          child: Image(
                            image: AssetImage('assets/images/2753267.png'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            WelcomeText(
                              25,
                              FontWeight.w400,
                              AppLocalizations.of(context)
                                  .translate('search-welcome'),
                              paddingSide: EdgeInsets.only(top: 20),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 55,
                          width: 350,
                          margin: EdgeInsets.only(top: 100),
                          child: TextFormField(
                            onChanged: (value) => {
                              setState(() => _searchText =
                                  value[0].toUpperCase() + value.substring(1))
                            },
                            obscureText: false,
                            decoration: new InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color.fromRGBO(180, 175, 175, 1),
                                size: 24.0,
                              ),
                              labelText: AppLocalizations.of(context)
                                  .translate('search'),
                              labelStyle: new TextStyle(
                                fontFamily: "Mitr",
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                color: Color.fromRGBO(180, 175, 175, 1),
                              ),
                              fillColor: Color.fromRGBO(252, 254, 255, 1),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(180, 175, 175, 1),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(180, 175, 175, 1),
                                ),
                              ),
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(color: Colors.white),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Mitr",
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              color: Color.fromRGBO(85, 85, 85, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance
                                  .collection('Users data')
                                  .where('name',
                                      isGreaterThanOrEqualTo: _searchText)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (_searchText == '') {
                                  return Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 20,
                                      margin: EdgeInsets.only(top: 100),
                                      child: Text(
                                        ' ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Mitr',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(85, 85, 85, .8),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) => ProfileList(
                                      context,
                                      snapshot.data.documents[index],
                                      snapshot
                                          .data.documents[index].documentID),
                                );
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: TopOverlayBar(
                  isShowBackButton: true,
                ),
              ),
              Positioned(
                bottom: 0,
                child: BottomMenuBar(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
