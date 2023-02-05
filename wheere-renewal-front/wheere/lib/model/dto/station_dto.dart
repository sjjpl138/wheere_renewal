class StationDTO{
  int sId;
  String sName;

  StationDTO({
    required this.sId,
    required this.sName
  });

  factory StationDTO.fromJson(Map<String, dynamic> json) {
    return StationDTO(
      sId: json['id'],
      sName: json['name'],
    );
  }
}