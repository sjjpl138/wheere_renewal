import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/rating/rating_view.dart';
import 'package:wheere/view_model/rating_view_model.dart';

class RatingPage extends StatelessWidget {
  final AlarmReservationDTO reservation;

  const RatingPage({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RatingViewModel>(
      create: (_) => RatingViewModel(reservation: reservation),
      child: Consumer<RatingViewModel>(
        builder: (context, provider, child) => RatingView(
          ratingViewModel: provider,
        ),
      ),
    );
  }
}
