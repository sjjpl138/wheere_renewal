import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view_model/home_view_model.dart';

import '../login/login_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel _homeViewModel;

  @override
  Widget build(BuildContext context) {
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    return Consumer<HomeViewModel>(
      builder: (context, provider, child) {
        return provider.member == null ? const LoginPage() : Container();
      },
    );
  }
}
