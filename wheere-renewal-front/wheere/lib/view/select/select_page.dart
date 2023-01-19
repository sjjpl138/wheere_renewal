import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/select/select_view.dart';
import 'package:wheere/view_model/select_view_model.dart';

class SelectPage extends StatelessWidget {
  final RouteFullListDTO routeFullListDTO;

  const SelectPage({super.key, required this.routeFullListDTO});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SelectViewModel>(
      create: (_) => SelectViewModel(routeFullListDTO: routeFullListDTO),
      child: Consumer<SelectViewModel>(
        builder: (context, provider, child) => SelectView(
          selectViewModel: provider,
        ),
      ),
    );
  }
}
