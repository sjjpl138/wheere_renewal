class StationDTO{
  String sSeq;
  String sName;

  StationDTO({
    required this.sSeq,
    required this.sName
  });

  factory StationDTO.fromJson(Map<String, dynamic> json) {
    return StationDTO(
      sSeq: json['sSeq'],
      sName: json['name'],
    );
  }
}