class ItemDTO{
  String nodenm;
  String vehicleno;

  ItemDTO({
    required this.nodenm,
    required this.vehicleno
  });

  factory ItemDTO.fromJson(Map<String, dynamic> json) {
    return ItemDTO(
      nodenm: json["nodenm"],
      vehicleno: json["vehicleno"],
    );
  }
}