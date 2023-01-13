import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view/login/login_view.dart';
import 'package:wheere/view_model/login_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, provider, child) => LoginView(
          loginViewModel: provider,
        ),
      ),
    );
  }
}
