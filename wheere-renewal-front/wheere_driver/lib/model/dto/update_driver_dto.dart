class UpdateDriverDTO{
  String dId;
  String dName;

  UpdateDriverDTO({
    required this.dId,
    required this.dName
  });

  Map<String, dynamic> toJson() => {
    'dId': dId,
    'dName': dName
  };
}