import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_view.dart';
import 'package:wheere/view_model/home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, provider, child) => HomeView(
          homeViewModel: provider,
        ),
      ),
    );
  }
}
