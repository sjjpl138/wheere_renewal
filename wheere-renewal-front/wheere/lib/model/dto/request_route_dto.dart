class RequestRouteDTO{
  double sx;
  double sy;
  double ex;
  double ey;
  String rDate;

  RequestRouteDTO({
    required this.sx,
    required this.sy,
    required this.ex,
    required this.ey,
    required this.rDate
  });

  Map<String, dynamic> toJson() => {
    'sx': sx,
    'sy': sy,
    'ex': ex,
    'ey': ey,
    'rDate': rDate
  };
}