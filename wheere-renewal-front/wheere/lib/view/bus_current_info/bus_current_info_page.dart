import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view_model/bus_current_info_view_model.dart';
import 'package:wheere/view_model/type/types.dart';
import 'bus_current_info_view.dart';

class BusCurrentInfoPage extends StatelessWidget {
  final ReservationData reservation;
  final BusLocationDTO busLocationDTO;

  const BusCurrentInfoPage({
    super.key,
    required this.reservation,
    required this.busLocationDTO,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BusCurrentInfoViewModel>(
      create: (_) => BusCurrentInfoViewModel(
        reservation: reservation,
        busLocationDTO: busLocationDTO,
      ),
      child: Consumer<BusCurrentInfoViewModel>(
        builder: (context, provider, child) => BusCurrentInfoView(
          busCurrentInfoViewModel: provider,
        ),
      ),
    );
  }
}
