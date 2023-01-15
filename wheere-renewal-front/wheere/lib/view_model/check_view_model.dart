import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';

class CheckViewModel extends ChangeNotifier {
  List<ReservationDTO> reservations = [
    ReservationDTO(),
    ReservationDTO(),
    ReservationDTO(),
    ReservationDTO(),
  ];
}