class UpdateDriverDTO{
  String dId;
  String dName;
  String vNo;
  String bNo;

  UpdateDriverDTO({
    required this.dId,
    required this.dName,
    required this.vNo,
    required this.bNo
  });

  Map<String, dynamic> toJson() => {
    'dId': dId,
    'dName': dName,
    'vNo': vNo,
    'bNo': bNo
  };
}