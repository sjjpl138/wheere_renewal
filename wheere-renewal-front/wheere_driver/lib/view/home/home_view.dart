import 'package:flutter/material.dart';
import 'package:wheere_driver/view/main/main_page.dart';
import 'package:wheere_driver/view/login/login_page.dart';
import 'package:wheere_driver/view_model/type/types.dart';

class HomeView extends StatefulWidget {
  final Driver driver;

  const HomeView({Key? key, required this.driver}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final Driver _driver = widget.driver;

  @override
  Widget build(BuildContext context) {
    return _driver.driver == null ? const LoginPage() : const MainPage();
  }
}
