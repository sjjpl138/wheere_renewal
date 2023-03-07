import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/payment/payment_page.dart';
import 'type/types.dart';

class SelectTabViewModel extends ChangeNotifier {
  final RoutesByHours routesByHours;
  final String rDate;

  SelectTabViewModel({
    required this.routesByHours,
    required this.rDate,
  });

  Future navigateToPaymentPage(BuildContext context, RouteData routeData) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          routeData: routeData,
          rDate: rDate,
        ),
      ),
    ).then((value) => value ?? false ? Navigator.pop(context) : null);
  }
}
