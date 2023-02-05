import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/util/utils.dart';
import 'package:wheere/view_model/sign_up_view_model.dart';

import '../common/commons.dart';

class SignUpView extends StatefulWidget {
  final SignUpViewModel signUpViewModel;

  const SignUpView({Key? key, required this.signUpViewModel}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final SignUpViewModel _signUpViewModel = widget.signUpViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        title: "회원가입",
        leading: BackIconButton(
            onPressed: () => _signUpViewModel.navigatePop(context)),
      ),
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
                  Form(
                    key: _signUpViewModel.signUpKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText: "이메일",
                          hintText: "Email",
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateEmail(value),
                          controller: _signUpViewModel.emailController,
                        ),
                        const SizedBox(height: kPaddingLargeSize),
                        CustomTextFormField(
                          labelText: "비밀번호",
                          hintText: "Password",
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => validatePassword(value),
                          controller: _signUpViewModel.passwordController,
                        ),
                        const SizedBox(height: kPaddingLargeSize),
                        CustomTextFormField(
                          labelText: "이름",
                          hintText: "이름",
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.text,
                          validator: (value) => validateName(value),
                          controller: _signUpViewModel.nameController,
                        ),
                        const SizedBox(height: kPaddingLargeSize),
                        SexRadioField(
                          groupValue: _signUpViewModel.sex,
                          onChanged: _signUpViewModel.onSexChanged,
                        ),
                        const SizedBox(height: kPaddingLargeSize),
                        CustomDatePicker(
                          onDateTimeChanged:
                              _signUpViewModel.onBirthDateChanged,
                          initDate: DateTime.now(),
                          title: '생년월일',
                        ),
                        const SizedBox(height: kPaddingLargeSize),
                        CustomTextFormField(
                          labelText: "전화번호",
                          hintText: "전화번호",
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          validator: (value) => validatePhoneNumber(value),
                          controller: _signUpViewModel.phoneNumberController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kPaddingLargeSize),
                  CustomOutlinedButton(
                    onPressed: () async {
                      await _signUpViewModel.signUp(context, mounted);
                    },
                    text: "회원가입",
                  ),
                  const SizedBox(height: kPaddingLargeSize),
                  CustomTextButton(
                    onPressed: () => _signUpViewModel.navigatePop(context),
                    text: "이미 회원이신가요?",
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
