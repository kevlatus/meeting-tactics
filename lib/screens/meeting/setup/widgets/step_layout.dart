import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StepLayout extends HookWidget {
  final Widget child;
  final Widget image;

  const StepLayout({
    Key key,
    this.child,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticker = useSingleTickerProvider();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (child != null)
              Card(
                child: AnimatedSize(
                  vsync: ticker,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: child,
                  ),
                ),
              ),
            if (image != null) image
          ],
        ),
      ),
    );
  }
}
