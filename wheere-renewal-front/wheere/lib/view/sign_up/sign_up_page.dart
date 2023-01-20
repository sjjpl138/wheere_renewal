import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view/sign_up/sign_up_view.dart';
import 'package:wheere/view_model/sign_up_view_model.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, provider, child) => SignUpView(
          signUpViewModel: provider,
        ),
      ),
    );
  }
}
