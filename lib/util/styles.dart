import 'package:flutter/widgets.dart';

List<Widget> withPadding({
  @required List<Widget> children,
  @required EdgeInsets padding,
}) {
  assert(children != null && children.length > 0);
  assert(padding != null);
  return children
      .map(
        (e) => Padding(
          padding: padding,
          child: e,
        ),
      )
      .toList();
}
