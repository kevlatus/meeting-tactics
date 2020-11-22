import 'package:flutter/material.dart';
import 'package:meet/widgets/widgets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static Page page() {
    return MaterialPage(
      key: const ValueKey('PrivacyPolicyPage'),
      child: const PrivacyPolicyScreen(),
    );
  }

  const PrivacyPolicyScreen();

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      builder: (context) {
        return Text('Privacy Policy');
      },
    );
  }
}
