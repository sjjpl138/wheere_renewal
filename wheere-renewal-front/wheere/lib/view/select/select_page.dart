import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/select/select_view.dart';
import 'package:wheere/view_model/select_view_model.dart';

import '../../view_model/type/types.dart';

class SelectPage extends StatelessWidget {
  final RouteFullList routeFullList;
  final String rDate;

  const SelectPage({
    super.key,
    required this.routeFullList,
    required this.rDate,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectViewModel>(
      create: (_) => SelectViewModel(
        routeFullList: routeFullList,
        rDate: rDate,
      ),
      child: Consumer<SelectViewModel>(
        builder: (context, provider, child) => SelectView(
          selectViewModel: provider,
        ),
      ),
    );
  }
}
