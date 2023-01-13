import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view_model/payment_view_model.dart';
import 'payment_view.dart';

class PaymentPage extends StatelessWidget {
  final List<BusDTO> reservations;

  const PaymentPage({super.key, required this.reservations});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaymentViewModel>(
      create: (_) => PaymentViewModel(reservations: reservations),
      child: Consumer<PaymentViewModel>(
        builder: (context, provider, child) => PaymentView(
          paymentViewModel: provider,
        ),
      ),
    );
  }
}
