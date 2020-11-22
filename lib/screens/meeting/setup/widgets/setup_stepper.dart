import 'package:flutter/material.dart';
import 'package:meet/widgets/widgets.dart';

import 'event_setup.dart';

class SetupStepper extends StatelessWidget {
  final VoidCallback onCompleted;

  const SetupStepper({
    Key key,
    this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final steps = [
      EventSetup(),
      // OrderSetup(),
      // TimerSetup(),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PageStepper(
            steps: steps,
            onCompleted: onCompleted,
          ),
        ),
      ),
    );
  }
}
