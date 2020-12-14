import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/widgets/widgets.dart';

import 'widgets/widgets.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageCtrl = usePageController();

    return AppLayout(builder: (context) {
      return PageView.builder(
        controller: pageCtrl,
        scrollDirection: Axis.vertical,
        pageSnapping: false,
        itemCount: 10,
        itemBuilder: (context, index) {
          if (index == 0) {
            return IntroPage(
              onNextPage: () {
                pageCtrl.animateToPage(
                  1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
            );
          } else {
            return Container();
          }
        },
      );
    });
  }
}
