import 'package:flutter/material.dart';
import 'package:meet/widgets/widgets.dart';

class LegalNoticeScreen extends StatelessWidget {
  static Page page() {
    return MaterialPage(
      key: const ValueKey('LegalNoticePage'),
      child: const LegalNoticeScreen(),
    );
  }

  const LegalNoticeScreen();

  @override
  Widget build(BuildContext context) {
    return AppLayout(builder: (context) {
      return Text('Legal Notice');
    });
  }
}
