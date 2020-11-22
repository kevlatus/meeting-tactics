import 'package:flutter/material.dart';
import 'package:router_v2/router_v2.dart';

class HyperLink extends StatelessWidget {
  final String href;
  final Widget child;
  final Color color;

  const HyperLink({
    Key key,
    @required this.href,
    this.child,
    this.color,
  })  : assert(href != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Router.of(context).push(href);
      },
      child: DefaultTextStyle(
        child: child ?? Text(href),
        style: theme.textTheme.bodyText2.copyWith(
          decoration: TextDecoration.underline,
          color: color ?? theme.primaryColor,
        ),
      ),
    );
  }
}
