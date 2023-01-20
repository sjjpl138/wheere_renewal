import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/payment/payment_page.dart';

class SelectTabViewModel extends ChangeNotifier {
  final RoutesByHoursDTO routesByHoursDTO;
  final String rDate;

  SelectTabViewModel({
    required this.routesByHoursDTO,
    required this.rDate,
  });

  void navigateToPaymentPage(BuildContext context, RouteDTO route) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentPage(routeDTO: route, rDate: rDate,)),
    );
  }
}
