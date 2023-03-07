import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view_model/type/types.dart';
import 'member_info_view.dart';
import 'package:wheere/view_model/member_info_view_model.dart';

class MemberInfoPage extends StatelessWidget {
  const MemberInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemberInfoViewModel()),
        ChangeNotifierProvider(create: (_) => Member()),
      ],
      child: Consumer2<MemberInfoViewModel, Member>(
        builder: (context, memberInfoViewModel, member, child) =>
            MemberInfoView(
          memberInfoViewModel: memberInfoViewModel,
          member: member,
        ),
      ),
    );
  }
}
