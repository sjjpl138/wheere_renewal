class RatingDTO{
  int rId;
  String bId;
  double rate;

  RatingDTO({
    required this.rId,
    required this.bId,
    required this.rate
  });

  Map<String, dynamic> toJson() => {
    'rId': rId,
    'rate': rate,
  };
}