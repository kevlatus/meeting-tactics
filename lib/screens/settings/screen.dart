import 'package:flutter/material.dart';
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
      return Text('Settings');
    });
  }
}
