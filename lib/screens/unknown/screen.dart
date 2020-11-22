import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  static Page page() {
    return MaterialPage(
      key: const ValueKey('UnknownPage'),
      child: UnknownScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text('404 - not found');
  }
}
