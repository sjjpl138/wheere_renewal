class RatingDTO{
  int rId;
  double rate;

  RatingDTO({
    required this.rId,
    required this.rate
  });

  Map<String, dynamic> toJson() => {
    'rId': rId,
    'rate': rate,
  };
}