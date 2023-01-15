import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view_model/member_info_edit_view_model.dart';

import 'member_info_edit_view.dart';

class MemberInfoEditPage extends StatelessWidget {
  const MemberInfoEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemberInfoEditViewModel>(
      create: (_) => MemberInfoEditViewModel(),
      child: Consumer<MemberInfoEditViewModel>(
        builder: (context, provider, child) => MemberInfoEditView(
          memberInfoEditViewModel: provider,
        ),
      ),
    );
  }
}
