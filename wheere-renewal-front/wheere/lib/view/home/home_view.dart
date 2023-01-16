import 'package:flutter/material.dart';
import 'package:wheere/view/main/main_page.dart';
import 'package:wheere/view/login/login_page.dart';
import 'package:wheere/view_model/type/types.dart';

class HomeView extends StatefulWidget {
  final Member member;

  const HomeView({Key? key, required this.member}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final Member _member = widget.member;

  @override
  Widget build(BuildContext context) {
    return _member.member == null ? const LoginPage() : const MainPage();
  }
}
