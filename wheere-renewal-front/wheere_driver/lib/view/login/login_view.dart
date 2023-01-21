import 'package:flutter/material.dart';
import 'package:wheere_driver/styles/colors.dart';
import 'package:wheere_driver/styles/sizes.dart';
import 'package:wheere_driver/styles/text_styles.dart';
import 'package:wheere_driver/util/utils.dart';
import 'package:wheere_driver/view_model/login_view_model.dart';
import 'package:wheere_driver/view/common/commons.dart';

class LoginView extends StatefulWidget {
  final LoginViewModel loginViewModel;

  const LoginView({Key? key, required this.loginViewModel}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginViewModel _loginViewModel = widget.loginViewModel;

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
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kPaddingLargeSize),
                  //TODO : App Icon 그림자 추가 필요
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                    ),
                  ),
                  const SizedBox(height: kPaddingLargeSize),
                  Form(
                    key: _loginViewModel.loginKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText: "이메일",
                          hintText: "Email",
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateEmail(value),
                          controller: _loginViewModel.emailController,
                        ),
                        const SizedBox(height: kPaddingLargeSize),
                        CustomTextFormField(
                          labelText: "비밀번호",
                          hintText: "Password",
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => validatePassword(value),
                          controller: _loginViewModel.passwordController,
                        ),
                        const SizedBox(height: kPaddingLargeSize),
                        CustomTextFormField(
                          labelText: "버스번호",
                          hintText: "버스번호",
                          prefixIcon: Icons.directions_bus,
                          keyboardType: TextInputType.text,
                          validator: (value) => validateVehicleNo(value),
                          controller: _loginViewModel.busNoController,
                        ),
                        const SizedBox(height: kPaddingLargeSize),
                        CustomTextFormField(
                          labelText: "차랑번호",
                          hintText: "차량번호",
                          prefixIcon: Icons.directions_car,
                          keyboardType: TextInputType.text,
                          validator: (value) => validateVehicleNo(value),
                          controller: _loginViewModel.vehicleNoController,
                        ),
                        const SizedBox(height: kPaddingLargeSize),
                        CustomTextFormField(
                          labelText: "배차순번",
                          hintText: "배차순번",
                          prefixIcon: Icons.format_list_numbered,
                          keyboardType: TextInputType.number,
                          validator: (value) => validateBusNo(value),
                          controller: _loginViewModel.outNoController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kPaddingLargeSize),
                  CustomOutlinedButton(
                    onPressed: () async {
                      await _loginViewModel.login();
                    },
                    text: "로그인",
                  ),
                  const SizedBox(height: kPaddingLargeSize),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
