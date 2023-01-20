import 'package:validators/validators.dart';

String? validateEmail(String? value) {
  if (value!.isEmpty) {
    return "공백이 들어갈 수 없습니다.";
  } else if (!isEmail(value)) {
    return "이메일 형식에 맞지 않습니다.";
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return "공백이 들어갈 수 없습니다.";
  } else if (value.length > 12) {
    return "패스워드의 길이를 초과하였습니다.";
  } else if (value.length < 6) {
    return "패스워드의 최소 길이는 6자입니다.";
  } else {
    return null;
  }
}

String? validateName(String? value) {
  if (value!.isEmpty) {
    return "공백이 들어갈 수 없습니다.";
  } else if (value.length > 12) {
    return "이름의 길이를 초과하였습니다.";
  } else if (value.length < 2) {
    return "이름의 최소 길이는 2자입니다.";
  } else {
    return null;
  }
}

String? validatePhoneNumber(String? value) {
  if (value!.isEmpty) {
    return "공백이 들어갈 수 없습니다.";
  } else if (value.length != 11) {
    return "전화번호의 형식에 맞지 않습니다.";
  } else {
    return null;
  }
}
