import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          color: CustomColor.backgroundMainColor,
          child: Padding(
            padding: const EdgeInsets.all(kPaddingSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: const [
                //TODO : App Icon 그림자 추가 필요
                Icon(
                  Icons.directions_bus,
                  color: CustomColor.itemSubColor,
                  size: 200.0,
                ),
                Text(
                  "WHEERE",
                  style: kTextMainStyleLarge,
                ),
                CustomTextFormField(
                  labelText: "이메일",
                  hintText: "Email",
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: null,
                  controller: null,
                ),
                SizedBox(
                  height: kPaddingSize,
                ),
                CustomTextFormField(
                  labelText: "비밀번호",
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                  keyboardType: TextInputType.visiblePassword,
                  validator: null,
                  controller: null,
                ),
                SizedBox(
                  height: kPaddingSize,
                ),
                CustomOutlinedButton(
                  onPressed: null,
                  text: "로그인",
                ),
                SizedBox(
                  height: kPaddingSize,
                ),
                CustomTextButton(text: "회원이 아니신가요?")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
