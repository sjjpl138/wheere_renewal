import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere_driver/view_model/type/types.dart';
import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Driver>(
      create: (_) => Driver(),
      child: Consumer<Driver>(
        builder: (context, provider, child) => HomeView(
          driver: provider,
        ),
      ),
    );
  }
}
