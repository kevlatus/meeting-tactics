import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meet/constants.dart';
import 'package:meet/routes.dart';

import 'app_footer.dart';

class _SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isSettingsActive =
        ModalRoute.of(context).settings.name == AppRouter.settings;
    if (isSettingsActive) {
      return Container();
    }

    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.of(context).pushNamed(AppRouter.settings);
      },
    );
  }
}

class _AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/app-icon.png',
      width: 24,
      height: 24,
    );
  }
}

class AppLayout extends StatelessWidget {
  final WidgetBuilder builder;

  const AppLayout({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobileHome = !kIsWeb;

    final appIcon = isMobileHome
        ? Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _AppIcon(),
          )
        : Container();

    return Scaffold(
      appBar: AppBar(
        leading: kIsWeb ? _AppIcon() : null,
        title: Row(
          children: [
            appIcon,
            Text(kAppName),
          ],
        ),
        actions: [
          _SettingsButton(),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Builder(builder: builder),
            ]),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(child: Container()),
                //AppFooter(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
