import 'package:flutter/material.dart';

class RandomDurationSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Min Duration:'),
            Spacer(),
          ],
        ),
        Row(
          children: [
            Text('Max Duration:'),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
