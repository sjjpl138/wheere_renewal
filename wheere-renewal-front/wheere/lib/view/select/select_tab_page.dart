import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/select/select_tab_view.dart';
import 'package:wheere/view_model/select_tab_view_model.dart';

class SelectTabPage extends StatelessWidget {
  final List<RouteDTO> routes;

  const SelectTabPage({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectTabViewModel>(
      create: (_) => SelectTabViewModel(routes: routes),
      child: Consumer<SelectTabViewModel>(
        builder: (context, provider, child) => SelectTabView(
          selectTabViewModel: provider,
        ),
      ),
    );
  }
}
