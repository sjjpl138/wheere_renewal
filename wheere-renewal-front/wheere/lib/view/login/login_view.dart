import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/login_view_model.dart';
import 'package:wheere/util/utils.dart';

class LoginView extends StatefulWidget {
  final LoginViewModel loginViewModel;

  const LoginView({Key? key, required this.loginViewModel}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginViewModel _loginViewModel = widget.loginViewModel;

  final loginKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(context, title: ""),
      body: SingleChildScrollView(
        child: Container(
          color: CustomColor.backgroundMainColor,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(kPaddingLargeSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: kPaddingLargeSize),
                  //TODO : App Icon 그림자 추가 필요
                  Flexible(
                      child: Column(
                    children: const [
                      Icon(
                        Icons.directions_bus,
                        color: CustomColor.itemSubColor,
                        size: 200.0,
                      ),
                      Text(
                        "WHEERE",
                        style: kTextMainStyleLarge,
                      ),
                    ],
                  )),
                  const SizedBox(height: kPaddingLargeSize),
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
                        const SizedBox(height: kPaddingLargeSize),
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
                  const SizedBox(height: kPaddingLargeSize),
                  CustomOutlinedButton(
                    onPressed: () async {
                      if (loginKey.currentState!.validate()) {
                        await _loginViewModel.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                    text: "로그인",
                  ),
                  const SizedBox(height: kPaddingLargeSize),
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
