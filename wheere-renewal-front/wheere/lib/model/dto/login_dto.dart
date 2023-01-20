class LoginDTO {
  String mId;
  String fcmToken;

  LoginDTO({
    required this.mId,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "mId": mId,
      "token": fcmToken,
    };
  }
}