import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../components/TopOverlayBar.dart';
import '../components/WelcomeText.dart';
import '../model/User.dart';
import '../services/AppLanguage.dart';
import '../services/AppLocalizations.dart';
import '../wrapper.dart';

class UpdateDataScreen extends StatefulWidget {
  final DocumentSnapshot document;
  UpdateDataScreen({this.document});
  @override
  _UpdateDataScreenState createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  String _name;
  String _studentID;
  String _userStatus;
  String _image;
  String _phonenumber;

  final imagePicker = ImagePicker();
  final storage = FirebaseStorage(storageBucket: 'gs://schedie-2.appspot.com/');

  File _imageFile;

  String _uploadStatus = 'Upload Image';
  bool isImageUploaded = false;

  Future getImage() async {
    final image = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      _uploadStatus = 'Upload Image';
      _imageFile = File(image.path);
    });
  }

  Future uploadImage() async {
    setState(() {
      _uploadStatus = 'Uploading';
    });
    String imageName = basename(_imageFile.path);
    StorageReference storageRef = storage.ref().child(imageName);
    StorageUploadTask uploadTask = storageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    if (taskSnapshot.error == null) {
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        isImageUploaded = true;
        _image = imageUrl;
        _uploadStatus = 'Upload completed';
      });
    } else {
      print(taskSnapshot.error);
      setState(() {
        _uploadStatus = 'Upload Error';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _image = widget.document.data['imageProfile'];
    _name = widget.document.data['name'];
    _studentID = widget.document.data['studentID'];
    _userStatus = widget.document.data['userStatus'];
    _phonenumber = widget.document.data['phoneNumber'];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    var appLanguage = Provider.of<AppLanguage>(context);

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Form(
            key: _signUpFormKey,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 6),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          WelcomeText(
                              25,
                              FontWeight.w500,
                              AppLocalizations.of(context)
                                  .translate('edit-header'))
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 105,
                          backgroundImage: NetworkImage(_image),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            onPressed: () async {
                              await getImage();
                              await uploadImage();
                            },
                            child: Text(
                              _uploadStatus,
                              style: TextStyle(
                                  fontFamily: 'Mitr',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300),
                            ))
                      ],
                    ),
                    Container(
                      height: 55,
                      width: 350,
                      margin: EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        initialValue: _name,
                        validator: (value) => value.isNotEmpty
                            ? null
                            : AppLocalizations.of(context)
                                .translate('name-isEmpty'),
                        onChanged: (value) => {setState(() => _name = value)},
                        obscureText: false,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          labelText:
                              AppLocalizations.of(context).translate('name'),
                          labelStyle: new TextStyle(
                              fontFamily: "Mitr",
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                          fillColor: Color.fromRGBO(62, 230, 192, 1),
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
                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                            fontFamily: "Mitr",
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: 350,
                      margin: EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        initialValue: _userStatus,
                        validator: (value) => value.isNotEmpty
                            ? null
                            : AppLocalizations.of(context)
                                .translate('user-status-isEmpty'),
                        onChanged: (value) =>
                            {setState(() => _userStatus = value)},
                        obscureText: false,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_box,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('user-status'),
                          labelStyle: new TextStyle(
                              fontFamily: "Mitr",
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                          fillColor: Color.fromRGBO(62, 230, 192, 1),
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
                        keyboardType: TextInputType.text,
                        style: new TextStyle(
                            fontFamily: "Mitr",
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
                    ),
                    _studentID != null
                        ? Container(
                            height: 55,
                            width: 350,
                            margin: EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              initialValue: _studentID,
                              onChanged: (value) =>
                                  {setState(() => _studentID = value)},
                              obscureText: false,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.school,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                labelText: AppLocalizations.of(context)
                                    .translate('student-id'),
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
                              keyboardType: TextInputType.number,
                              style: new TextStyle(
                                  fontFamily: "Mitr",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          )
                        : Padding(padding: EdgeInsets.all(0)),
                    Container(
                      height: 55,
                      width: 350,
                      margin: EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        initialValue: _phonenumber,
                        validator: (value) => value.isNotEmpty
                            ? null
                            : AppLocalizations.of(context)
                                .translate('phone-not-10'),
                        onChanged: (value) =>
                            {setState(() => _phonenumber = value)},
                        obscureText: false,
                        decoration: new InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('phone-number'),
                          labelStyle: new TextStyle(
                              fontFamily: "Mitr",
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                          fillColor: Color.fromRGBO(62, 230, 192, 1),
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
                        keyboardType: TextInputType.number,
                        style: new TextStyle(
                            fontFamily: "Mitr",
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 350,
                      margin: EdgeInsets.only(top: 10, bottom: 50),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ButtonTheme(
                          minWidth: 350,
                          height: 50,
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () async {
                              if (_signUpFormKey.currentState.validate()) {
                                await Firestore.instance
                                    .collection('Users data')
                                    .document(user.uid)
                                    .updateData({
                                  'name': _name,
                                  'phoneNumber': _phonenumber,
                                  'imageProfile': _image,
                                  'studentID': _studentID,
                                  'userStatus': _userStatus
                                });
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => new Wrapper(),
                                  ),
                                );
                              }
                            },
                            color: Color.fromRGBO(255, 211, 138, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 24,
                                  height: 24,
                                  margin: EdgeInsets.only(right: 10),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/account.png'),
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('update'),
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
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 20,
              right: 20,
              child: TopOverlayBar(
                isShowBackButton: true,
              )),
        ],
      )),
    );
  }
}
