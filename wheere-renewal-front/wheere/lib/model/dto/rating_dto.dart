class RatingDTO{
  String rId;
  String bId;
  double rate;

  RatingDTO({
    required this.rId,
    required this.rate,
    required this.bId,
  });

  Map<String, dynamic> toJson() => {
    'rId': rId,
    'rate': rate,
    'bId': bId,
  };
}