import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';

class RatingViewModel extends ChangeNotifier {
  final ReservationDTO reservation;

  double rating = 3.0;

  RatingViewModel({required this.reservation});

  void navigatePop() {}

  void updateRating(double rating) {
    this.rating = rating;
    notifyListeners();
  }

  Future sendRating() async {}
}
