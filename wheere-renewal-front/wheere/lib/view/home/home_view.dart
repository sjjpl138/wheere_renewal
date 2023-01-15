import 'package:flutter/material.dart';
import 'package:wheere/view/main/main_page.dart';
import 'package:wheere/view_model/home_view_model.dart';
import 'package:wheere/view/login/login_page.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel homeViewModel;

  const HomeView({Key? key, required this.homeViewModel}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel _homeViewModel = widget.homeViewModel;

  @override
  Widget build(BuildContext context) {
    return _homeViewModel.member == null ? const LoginPage() : const MainPage();
  }
}
