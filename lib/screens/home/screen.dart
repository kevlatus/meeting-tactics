import 'package:flutter/material.dart';
import 'package:meet/widgets/widgets.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static Page page() {
    return MaterialPage(
      key: ValueKey('HomePage'),
      child: HomeScreen(),
    );
  }

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLayout(builder: (context) {
      return Column(
        children: [
          IntroBox(),
          // TacticsBox(),
        ],
      );
    });
  }
}
