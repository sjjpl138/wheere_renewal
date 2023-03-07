class LoginDTO{
  String dId;
  String vNo;
  int bOutNo;
  String bNo;
  String fcmToken;

  LoginDTO({
    required this.dId,
    required this.vNo,
    required this.bOutNo,
    required this.bNo,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() => {
    'dId': dId,
    'vNo': vNo,
    'bOutNo': bOutNo,
    'bNo': bNo,
    "fcmToken": fcmToken,
  };
}