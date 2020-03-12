class LoginRep {
  // 手机号
  String username;

  // 验证码
  String password;

  // 设备类型（1：IOS；2：Android）
  String deviceType;

  // 设备识别号
  String deviceToken;

  // 设备唯一标识
  String hostSerial;

  // APP 版本号
  String deviceVersion;

  LoginRep(
      {this.username,
      this.password,
      this.deviceType,
      this.deviceToken,
      this.hostSerial,
      this.deviceVersion});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['deviceType'] = this.deviceType;
    data['deviceToken'] = this.deviceToken;
    data['hostSerial'] = this.hostSerial;
    data['deviceVersion'] = this.deviceVersion;
    return data;
  }


}
