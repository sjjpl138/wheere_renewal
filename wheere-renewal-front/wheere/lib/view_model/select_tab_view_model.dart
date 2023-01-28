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

  Future navigateToPaymentPage(BuildContext context, RouteDTO route) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          routeDTO: route,
          rDate: rDate,
        ),
      ),
    ).then((value) => value ?? false ? Navigator.pop(context) : null);
  }
}
