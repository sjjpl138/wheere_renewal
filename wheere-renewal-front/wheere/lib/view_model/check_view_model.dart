import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/bus_current_info/bus_current_info_page.dart';

import 'type/types.dart';

class CheckViewModel extends ChangeNotifier {
  CheckViewModel() {
    print("checkViewModel is created");
    ReservationList().checkReservation("", "");
  }

  void navigateToBusCurrentInfoPage(
      BuildContext context, ReservationDTO reservation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusCurrentInfoPage(reservation: reservation),
      ),
    );
  }
}
