class LoginDTO{
  String bId;
  String vNo;
  int bOutNo;
  String bNo;

  LoginDTO({
    required this.bId,
    required this.vNo,
    required this.bOutNo,
    required this.bNo
  });

  Map<String, dynamic> toJson() => {
    'bId': bId,
    'vNo': vNo,
    'bOutNo': bOutNo,
    'bNo': bNo,
  };
}