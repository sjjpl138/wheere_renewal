import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view/check/check_view.dart';
import 'package:wheere/view_model/check_view_model.dart';
import 'package:wheere/view_model/type/types.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("checkPage is created");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckViewModel()),
        ChangeNotifierProvider(create: (_) => ReservationList()),
      ],
      child: Consumer2<CheckViewModel, ReservationList>(
        builder: (context, checkViewModel, reservationList, child) => CheckView(
          checkViewModel: checkViewModel,
          reservationList: reservationList,
        ),
      ),
    );
  }
}
