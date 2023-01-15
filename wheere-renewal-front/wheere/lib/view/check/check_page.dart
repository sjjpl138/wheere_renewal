import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view/check/check_view.dart';
import 'package:wheere/view_model/check_view_model.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckViewModel>(
      create: (_) => CheckViewModel(),
      child: Consumer<CheckViewModel>(
        builder: (context, provider, child) => CheckView(
          checkViewModel: provider,
        ),
      ),
    );
  }
}
