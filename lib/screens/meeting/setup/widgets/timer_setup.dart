import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class TimerSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingSetupCubit, MeetingSetupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Timer Setup'),
        );
      },
    );
  }
}
