class BusGetOffDTO{
  int bId;
  int rId;

  BusGetOffDTO({
    required this.bId,
    required this.rId
  });

  Map<String, dynamic> toJson() {
    return {
      "bId": bId
    };
  }
}