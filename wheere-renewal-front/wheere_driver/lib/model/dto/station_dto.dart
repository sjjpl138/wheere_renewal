class StationDTO{
  int sId;
  int sSeq;
  String sName;

  StationDTO({
    required this.sId,
    required this.sSeq,
    required this.sName
  });

  factory StationDTO.fromJson(Map<String, dynamic> json) {
    return StationDTO(
      sId: json['sId'],
      sSeq: json['sSeq'],
      sName: json['name'],
    );
  }
}