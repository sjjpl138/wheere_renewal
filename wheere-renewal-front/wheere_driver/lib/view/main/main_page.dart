import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere_driver/view/main/main_view.dart';
import 'package:wheere_driver/view_model/main_view_model.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainViewModel(),
      child: Consumer<MainViewModel>(
        builder: (context, mainViewModel, child) =>
            MainView(mainViewModel: mainViewModel),
      ),
    );
  }
}
