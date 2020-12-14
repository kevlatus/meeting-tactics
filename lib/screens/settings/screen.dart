import 'package:flutter/material.dart';
import 'package:meet/screens/settings/widgets/theme_selector.dart';
import 'package:meet/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  static Page page() {
    return MaterialPage(
      key: const ValueKey('SettingsPage'),
      child: const SettingsScreen(),
    );
  }

  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLayout(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('ThemeMode'),
                Spacer(),
                ThemeSelector(),
              ],
            ),
          ],
        ),
      );
    });
  }
}
