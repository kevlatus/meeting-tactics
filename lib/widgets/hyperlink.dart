import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HyperLink extends StatelessWidget {
  final String href;
  final Widget child;
  final Color color;
  final TextDecoration decoration;

  const HyperLink({
    Key key,
    @required this.href,
    this.child,
    this.color,
    this.decoration = TextDecoration.underline,
  })  : assert(href != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        if (href.startsWith(RegExp('https?://'))) {
          if(!await canLaunch(href)) {
            throw ArgumentError('Cannot launch url $href');
          }

          await launch(href);
        } else {
          Navigator.of(context).pushNamed(href);
        }
      },
      child: DefaultTextStyle(
        child: child ?? Text(href),
        style: theme.textTheme.bodyText2.copyWith(
          decoration: decoration,
          color: color ?? theme.primaryColor,
        ),
      ),
    );
  }
}
