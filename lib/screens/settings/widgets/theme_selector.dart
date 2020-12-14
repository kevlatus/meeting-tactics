import 'package:flutter/material.dart';
import 'package:meet/theme.dart';

class ThemeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final manipulator = ThemeManipulator.of(context);

    final List<ThemeMode> modes = <ThemeMode>[
      ThemeMode.system,
      ThemeMode.light,
      ThemeMode.dark,
    ];

    final List<bool> modeSelected = [
      for (var it in modes) manipulator.theme == it
    ];


    return ToggleButtons(
      isSelected: modeSelected,
      children: <Widget>[
        Text('system'),
        Text('light'),
        Text('dark'),
      ],
      onPressed: (int index) {
        manipulator.changeTheme(modes[index]);
      },
    );
  }
}
