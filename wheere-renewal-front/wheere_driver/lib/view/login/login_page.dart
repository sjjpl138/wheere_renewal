import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere_driver/view_model/login_view_model.dart';
import 'login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, loginViewModel, child) => LoginView(
          loginViewModel: loginViewModel,
        ),
      ),
    );
  }
}
