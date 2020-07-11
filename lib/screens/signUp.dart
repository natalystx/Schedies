import 'dart:io';

import 'package:flutter/material.dart';
import 'package:schedule_app/components/WelcomeText.dart';
import 'package:schedule_app/model/UserSignUp.dart';
import 'package:schedule_app/services/AuthService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  final AuthServices _auth = AuthServices();
  final imagePicker = ImagePicker();
  final storage = FirebaseStorage(storageBucket: 'gs://schedie-2.appspot.com/');
  // text fields state
  UserSignUp _user;
  String _email;
  String _password;
  String _confirmPassword;
  String _name;
  String _userStatus;
  String _phoneNumber;
  String _studentID;
  String _profileImage;
  String _error;
  dynamic result;
  File _image;

  String _uploadStatus = 'Upload Image';
  bool isImageUploaded = false;

  Future getImage() async {
    final image = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      _uploadStatus = 'Upload Image';
      _image = File(image.path);
    });
  }

  Future uploadImage() async {
    setState(() {
      _uploadStatus = 'Uploading';
    });
    String imageName = basename(_image.path);
    StorageReference storageRef = storage.ref().child(imageName);
    StorageUploadTask uploadTask = storageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    if (taskSnapshot.error == null) {
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        isImageUploaded = true;
        _profileImage = imageUrl;
        _uploadStatus = 'Upload completed';
      });
    } else {
      print(taskSnapshot.error);
      setState(() {
        _uploadStatus = 'Upload Error';
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      child:
                          Image(image: AssetImage('assets/images/3235815.png')),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    WelcomeText(15, FontWeight.w300, 'Welcome to')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    WelcomeText(
                      35,
                      FontWeight.w400,
                      'Schedie',
                      paddingSide: EdgeInsets.only(top: 0),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    WelcomeText(
                      15,
                      FontWeight.w300,
                      'The tools for manage your plans.',
                      paddingSide: EdgeInsets.only(bottom: 40),
                    )
                  ],
                ),
                Form(
                  key: _signUpFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 55,
                        width: 350,
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          validator: (value) => value.contains('@g.cmru.ac.th')
                              ? null
                              : 'You\'re not be apart of CMRU',
                          onChanged: (value) =>
                              {setState(() => _email = value)},
                          obscureText: false,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            labelText: 'Email',
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
                          keyboardType: TextInputType.emailAddress,
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
                          validator: (value) => value.length > 8
                              ? null
                              : 'Password Must be more than 8 characters.',
                          onChanged: (value) =>
                              {setState(() => _password = value)},
                          obscureText: true,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.dialpad,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            labelText: 'Password',
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
                          onChanged: (value) =>
                              {setState(() => _confirmPassword = value)},
                          validator: (value) => _password != value
                              ? 'Password and confirm password must be match.'
                              : null,
                          obscureText: true,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.dialpad,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            labelText: 'Confirm password',
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
                          validator: (value) =>
                              value.isNotEmpty ? null : 'Name can\' be empty.',
                          onChanged: (value) => {setState(() => _name = value)},
                          obscureText: false,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            labelText: 'Name',
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
                          validator: (value) => value.length >= 10
                              ? null
                              : 'Phonenumber must be more than 10 characters.',
                          onChanged: (value) =>
                              {setState(() => _phoneNumber = value)},
                          obscureText: false,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            labelText: 'Phonenumber',
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
                          keyboardType: TextInputType.phone,
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
                          validator: (value) => value.isNotEmpty
                              ? null
                              : 'User status can\'t be empty.',
                          onChanged: (value) =>
                              {setState(() => _userStatus = value)},
                          obscureText: false,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            labelText: 'User status',
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
                          onChanged: (value) =>
                              {setState(() => _studentID = value)},
                          obscureText: false,
                          decoration: new InputDecoration(
                            prefixIcon: Icon(
                              Icons.school,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            labelText: 'Student ID',
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
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(62, 220, 192, 1),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          height: 55,
                          width: 350,
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 10),
                                child: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                              ),
                              Container(
                                width: 300,
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    _image == null
                                        ? 'Image Profile'
                                        : '${_image.toString()}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: "Mitr",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: ButtonTheme(
                              minWidth: 350,
                              height: 50,
                              child: RaisedButton(
                                elevation: 0,
                                onPressed: () => {uploadImage()},
                                color: Color.fromRGBO(250, 137, 123, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      _uploadStatus,
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
                      )
                    ],
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
                            result = await _auth.signUpWithEmailAndPassword(
                                _email, _password,
                                name: _name,
                                phoneNumber: _phoneNumber,
                                userStatus: _userStatus,
                                imageProfile: _profileImage,
                                studentID: _studentID);
                            if (result == null) {
                              setState(() => _error =
                                  'Sign up failed. Please enter valid email.');
                            }
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
                                image: AssetImage('assets/images/account.png'),
                              ),
                            ),
                            Text(
                              'Sign up',
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
      )),
    );
  }
}
