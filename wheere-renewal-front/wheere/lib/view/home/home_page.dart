import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view_model/type/types.dart';
import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Member>(
      create: (_) => Member(),
      child: Consumer<Member>(
        builder: (context, provider, child) => HomeView(
          member: provider,
        ),
      ),
    );
  }
}
