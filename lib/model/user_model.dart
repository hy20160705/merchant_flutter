/// salerName : "名字"
/// inviteCode : "Duis 邀请码"
/// photoPath : "头像"
/// partition : "区域/地址"

class UserModel {
  String salerName;
  String inviteCode;
  String photoPath;
  String partition;

  static UserModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserModel userModelBean = UserModel();
    userModelBean.salerName = map['salerName'];
    userModelBean.inviteCode = map['inviteCode'];
    userModelBean.photoPath = map['photoPath'];
    userModelBean.partition = map['partition'];
    return userModelBean;
  }

  @override
  String toString() {
    return 'UserModel{salerName: $salerName, inviteCode: $inviteCode, photoPath: $photoPath, partition: $partition}';
  }
}
