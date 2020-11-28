import 'package:flutter/material.dart';

class HideNull extends StatelessWidget {
  final dynamic value;
  final Widget child;

  const HideNull({
    Key key,
    this.value,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == null ? Container() : child;
  }
}
