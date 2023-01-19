import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view_model/payment_view_model.dart';
import 'payment_view.dart';

class PaymentPage extends StatelessWidget {
  final RouteDTO routeDTO;
  final String rDate;

  const PaymentPage({
    super.key,
    required this.routeDTO,
    required this.rDate,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaymentViewModel>(
      create: (_) => PaymentViewModel(routeDTO: routeDTO, rDate: rDate),
      child: Consumer<PaymentViewModel>(
        builder: (context, provider, child) => PaymentView(
          paymentViewModel: provider,
        ),
      ),
    );
  }
}
