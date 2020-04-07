class UserModel {
  String msg;
  int code;
  UserInfo data;

  UserModel({this.msg, this.code, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {    
    this.msg = json['msg'];
    this.code = json['code'];
    this.data = json['data'] != null ? UserInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

}

class UserInfo {
  String salerName;
  String inviteCode;
  String photoPath;
  String partition;

  UserInfo({this.salerName, this.inviteCode, this.photoPath, this.partition});

  UserInfo.fromJson(Map<String, dynamic> json) {    
    this.salerName = json['salerName'];
    this.inviteCode = json['inviteCode'];
    this.photoPath = json['photoPath'];
    this.partition = json['partition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salerName'] = this.salerName;
    data['inviteCode'] = this.inviteCode;
    data['photoPath'] = this.photoPath;
    data['partition'] = this.partition;
    return data;
  }

  @override
  String toString() {
    return 'UserInfo{salerName: $salerName, inviteCode: $inviteCode, photoPath: $photoPath, partition: $partition}';
  }

}
