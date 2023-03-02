class UpdateDriverDTO{
  String dId;
  String dName;
  int bOutNo;
  String vNo;
  String bNo;

  UpdateDriverDTO({
    required this.dId,
    required this.dName,
    required this.bOutNo,
    required this.vNo,
    required this.bNo
  });

  Map<String, dynamic> toJson() => {
    'dId': dId,
    'dName': dName,
    'bOutNo': bOutNo,
    'vNo': vNo,
    'bNo': bNo
  };
}