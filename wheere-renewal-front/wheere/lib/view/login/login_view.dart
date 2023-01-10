import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/home_view_model.dart';
import 'package:wheere/view_model/login_view_model.dart';
import 'package:wheere/util/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late HomeViewModel _homeViewModel;
  late LoginViewModel _loginViewModel;

  final loginKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    _loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    return Center(
      child: SingleChildScrollView(
        child: Consumer<LoginViewModel>(
          builder: (context, provider, child) => Container(
            color: CustomColor.backgroundMainColor,
            child: Padding(
              padding: const EdgeInsets.all(kPaddingSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: kPaddingSize),
                  //TODO : App Icon 그림자 추가 필요
                  const Icon(
                    Icons.directions_bus,
                    color: CustomColor.itemSubColor,
                    size: 200.0,
                  ),
                  const Text(
                    "WHEERE",
                    style: kTextMainStyleLarge,
                  ),
                  const SizedBox(height: kPaddingSize),
                  Form(
                    key: loginKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText: "이메일",
                          hintText: "Email",
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateEmail(value),
                          controller: _emailController,
                        ),
                        const SizedBox(height: kPaddingSize),
                        CustomTextFormField(
                          labelText: "비밀번호",
                          hintText: "Password",
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => validatePassword(value),
                          controller: _passwordController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kPaddingSize),
                  CustomOutlinedButton(
                    onPressed: () async {
                      if (loginKey.currentState!.validate()) {
                        await _homeViewModel.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    text: "로그인",
                  ),
                  const SizedBox(height: kPaddingSize),
                  const CustomTextButton(
                    onPressed: null,
                    text: "회원이 아니신가요?",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
