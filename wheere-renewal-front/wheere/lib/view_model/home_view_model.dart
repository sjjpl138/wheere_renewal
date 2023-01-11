import 'package:flutter/material.dart';

import 'package:wheere/model/dto/dtos.dart';
import 'type/types.dart';

class HomeViewModel extends ChangeNotifier {
  MemberDTO? get member => _member.member;
  late Member _member;

  HomeViewModel() {
    _member = Member();
  }
}
