class LoginDTO{
  String dId;
  String vNo;
  int bOutNo;
  String bNo;

  LoginDTO({
    required this.dId,
    required this.vNo,
    required this.bOutNo,
    required this.bNo
  });

  Map<String, dynamic> toJson() => {
    'dId': dId,
    'vNo': vNo,
    'bOutNo': bOutNo,
    'bNo': bNo,
  };
}