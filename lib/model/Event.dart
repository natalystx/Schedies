class Event {
  String inviteUser;
  String startTime;
  String endTime;
  String topic;
  String details;
  List<String> moreInviteList;
  String location;

  Event(
      {this.inviteUser,
      this.details,
      this.endTime,
      this.location,
      this.moreInviteList,
      this.startTime,
      this.topic});
}
