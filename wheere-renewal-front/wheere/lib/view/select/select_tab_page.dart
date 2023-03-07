import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view/select/select_tab_view.dart';
import 'package:wheere/view_model/select_tab_view_model.dart';
import 'package:wheere/view_model/type/types.dart';

class SelectTabPage extends StatelessWidget {
  final RoutesByHours routesByHoursDTO;
  final String rDate;

  const SelectTabPage({
    super.key,
    required this.routesByHoursDTO,
    required this.rDate,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectTabViewModel>(
      create: (_) =>
          SelectTabViewModel(routesByHours: routesByHoursDTO, rDate: rDate),
      child: Consumer<SelectTabViewModel>(
        builder: (context, provider, child) => SelectTabView(
          selectTabViewModel: provider,
        ),
      ),
    );
  }
}
