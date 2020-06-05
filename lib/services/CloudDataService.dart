import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/model/UserSignUp.dart';

class CloudDataService {
  //firestore instance
  final Firestore firestore = Firestore.instance;
  //firestore Collection Reference

  final String uid;
  CloudDataService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('User Data');

  Future addUserData(String uid, String email, String name, String phoneNumber,
      String userStatus,
      {String studentID, String imageProfile}) async {
    await firestore.collection("Users data").document(uid).setData({
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'userStatus': userStatus,
      'studentID': studentID,
      'imageProfile': imageProfile
    });
  }

  Future addEventData(String uid, String date, String topic, String details,
      String inviteUser, String startTime, String endTime, String location,
      {List<String> moreInvite}) async {
    await firestore
        .collection("Events")
        .document('$uid+$date+$inviteUser+$startTime+$endTime')
        .setData({
      'topic': topic,
      'inviteUser': inviteUser,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
      'details': details,
      'date': date,
      'moreInvite': moreInvite,
      'uid': uid
    });
  }
}
