import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheere/view/alarm/alarm_view.dart';
import 'package:wheere/view_model/alarm_view_model.dart';


class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AlarmViewModel>(
      create: (_) => AlarmViewModel(),
      child: Consumer<AlarmViewModel>(
        builder: (context, provider, child) => AlarmView(
          alarmViewModel: provider,
        ),
      ),
    );
  }
}
