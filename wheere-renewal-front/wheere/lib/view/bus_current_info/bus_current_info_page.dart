import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/model/dto/bus_dto.dart';
import 'package:wheere/view_model/bus_current_info_view_model.dart';
import 'bus_current_info_view.dart';

class BusCurrentInfoPage extends StatelessWidget {
  final BusDTO reservation;

  const BusCurrentInfoPage({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BusCurrentInfoViewModel>(
      create: (_) => BusCurrentInfoViewModel(reservation: reservation),
      child: Consumer<BusCurrentInfoViewModel>(
        builder: (context, provider, child) => BusCurrentInfoView(
          busCurrentInfoViewModel: provider,
        ),
      ),
    );
  }
}