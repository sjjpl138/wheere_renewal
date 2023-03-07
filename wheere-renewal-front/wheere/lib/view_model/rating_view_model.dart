import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/rating_service.dart';

class RatingViewModel extends ChangeNotifier {
  final RatingService ratingService = RatingService();
  final AlarmReservationDTO reservation;

  double rating = 3.0;

  RatingViewModel({required this.reservation});

  void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }

  void updateRating(double rating) {
    this.rating = rating;
    notifyListeners();
  }

  Future sendRating(BuildContext context, bool mounted) async {
    await ratingService.rating(RatingDTO(
      rId: reservation.rId,
      rate: rating,
      bId: reservation.bId,
    ));
    if (mounted) navigatePop(context);
  }
}
