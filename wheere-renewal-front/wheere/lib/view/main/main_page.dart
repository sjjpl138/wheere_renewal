import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view_model/main_view_model.dart';
import 'main_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainViewModel>(
      create: (_) => MainViewModel(),
      child: Consumer<MainViewModel>(
        builder: (context, provider, child) => MainView(
          mainViewModel: provider,
        ),
      ),
    );
  }
}
