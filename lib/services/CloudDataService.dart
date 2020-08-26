import 'package:cloud_firestore/cloud_firestore.dart';

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
      'imageProfile': imageProfile
    });
  }

  Future addEventData(
      String myUID,
      String uid,
      String date,
      String topic,
      String details,
      String inviteUser,
      String startTime,
      String endTime,
      String location,
      String eventStatus,
      {List<dynamic> moreInvite,
      dynamic eventMemberList,
      List<dynamic> uidList,
      List<dynamic> moreInviteProfile}) async {
    await firestore
        .collection("Events")
        .document('$myUID+$uid+$date+$inviteUser+$startTime+$endTime')
        .setData({
      'topic': topic,
      'onCreatedTime': DateTime.now().toIso8601String(),
      'inviteUser': inviteUser,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
      'details': details,
      'date': date,
      'moreInvite': moreInvite ?? '',
      'receiver': uid,
      'sender': myUID,
      'eventStatus': eventStatus,
      'userCount': 2 + (moreInvite != null ? moreInvite.length : 0),
      'eventMemberList': eventMemberList,
      'uidList': uidList,
      'moreInviteProfile': moreInviteProfile
    });
  }

  Future updateEventData(
      String eventId,
      String myUID,
      String uid,
      String date,
      String topic,
      String details,
      String inviteUser,
      String startTime,
      String endTime,
      String location,
      String eventStatus,
      {List<dynamic> moreInvite,
      dynamic eventMemberList,
      List<dynamic> uidList,
      List<dynamic> moreInviteProfile}) async {
    await firestore.collection("Events").document(eventId).updateData({
      'topic': topic,
      'onCreatedTime': DateTime.now().toIso8601String(),
      'inviteUser': inviteUser,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
      'details': details,
      'date': date,
      'moreInvite': moreInvite ?? '',
      'receiver': uid,
      'sender': myUID,
      'eventStatus': eventStatus,
      'userCount': 2 + (moreInvite != null ? moreInvite.length : 0),
      'eventMemberList': eventMemberList,
      'uidList': uidList,
      'moreInviteProfile': moreInviteProfile
    });
  }
}
