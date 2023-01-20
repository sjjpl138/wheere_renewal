class StationDTO{
  int sId;
  String sName;
  int sSeq;

  StationDTO({
    required this.sId,
    required this.sName,
    required this.sSeq
  });

  factory StationDTO.fromJson(Map<String, dynamic> json) {
    return StationDTO(
      sId: json["sId"],
      sName: json["sName"],
      sSeq: json["sSeq"],
    );
  }
}