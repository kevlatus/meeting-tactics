import 'package:flutter/material.dart';
import 'package:meet/widgets/widgets.dart';

class TacticsScreen extends StatelessWidget {
  static Page page() {
    return MaterialPage(
      key: const ValueKey('TacticsPage'),
      child: const TacticsScreen(),
    );
  }

  const TacticsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLayout(builder: (context) {
      return Column(
        children: [],
      );
    });
  }
}
