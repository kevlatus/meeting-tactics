import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:meet/routes.dart';
import 'package:meet/widgets/widgets.dart';

class IntroPage extends StatelessWidget {
  final VoidCallback onNextPage;

  const IntroPage({
    Key key,
    this.onNextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final texts = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      color: theme.primaryColor.withAlpha(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SvgOrPngImage(
              'assets/images/img-flexiple-virtual-office-girl.png',
            ),
          ),
          Text(
            'Are you also bored by repetitive status meetings?',
            textAlign: TextAlign.center,
            style: theme.textTheme.headline6,
          ),
          SizedBox(height: 16),
          Text(
            'Get started below to make them more engaging.',
            textAlign: TextAlign.center,
            style: theme.textTheme.subtitle1,
          ),
          Container(height: 16),
          ElevatedButton(
            child: Text(texts.home_quick_start),
            onPressed: () async {
              Navigator.of(context).pushNamed(AppRouter.meetingSetup);
            },
          ),
          // OutlinedButton(
          //   child: Text('or learn more...'),
          //   onPressed: () {
          //     if (onNextPage != null) {
          //       onNextPage();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
