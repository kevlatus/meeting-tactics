import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/widgets/page_stepper/page_stepper.dart';

import '../bloc.dart';

class OrderSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingSetupBloc, MeetingSetupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Order Setup'),
              StepperActions(),
            ],
          ),
        );
      },
    );
  }
}
