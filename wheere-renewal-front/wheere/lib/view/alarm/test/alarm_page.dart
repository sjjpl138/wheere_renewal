import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view/alarm/alarm_view.dart';
import 'package:wheere/view_model/alarm_test_view_model.dart';
import 'package:wheere/view_model/alarm_view_model.dart';

import 'alarm_view.dart';


class AlarmTestPage extends StatelessWidget {
  const AlarmTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AlarmTestViewModel>(
      create: (_) => AlarmTestViewModel(),
      child: Consumer<AlarmTestViewModel>(
        builder: (context, provider, child) => AlarmTestView(
          alarmViewModel: provider,
        ),
      ),
    );
  }
}
