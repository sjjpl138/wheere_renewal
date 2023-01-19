import 'package:flutter/material.dart';
import 'package:wheere/view/home/home_page.dart';
import 'package:wheere/view_model/type/types.dart';


class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Payment? groupValue = Payment.onSite;
  bool isNewAlarm = true;

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
