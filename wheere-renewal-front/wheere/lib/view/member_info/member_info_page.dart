import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'member_info_view.dart';
import 'package:wheere/view_model/member_info_view_model.dart';

class MemberInfoPage extends StatelessWidget {
  const MemberInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemberInfoViewModel>(
      create: (_) => MemberInfoViewModel(),
      child: Consumer<MemberInfoViewModel>(
        builder: (context, provider, child) => MemberInfoView(
          userInfoViewModel: provider,
        ),
      ),
    );
  }
}
