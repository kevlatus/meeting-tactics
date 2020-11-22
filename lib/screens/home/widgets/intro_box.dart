import 'package:flutter/material.dart';
import 'package:router_v2/router_v2.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroBox extends StatelessWidget {
  const IntroBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final texts = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      color: theme.primaryColor.withAlpha(30),
      child: Column(
        children: [
          Text(
            texts.home_greeting_line_1,
            textAlign: TextAlign.center,
            style: theme.textTheme.headline6,
          ),
          Container(height: 8),
          Text(
            texts.home_greeting_line_2,
            textAlign: TextAlign.center,
            style: theme.textTheme.subtitle1,
          ),
          Container(height: 8),
          ElevatedButton(
            child: Text(texts.home_quick_start),
            onPressed: () async {
              Router.of(context).push('/meeting/setup');
            },
          ),
        ],
      ),
    );
  }
}
