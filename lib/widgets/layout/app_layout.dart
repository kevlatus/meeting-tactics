import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:meet/constants.dart';
import 'package:meet/router.gr.dart';
import 'package:meet/widgets/layout/app_header.dart';

import 'app_footer.dart';

class _SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isSettingsActive =
        AutoRouter.of(context).current.name == SettingsRoute.name;
    if (isSettingsActive) {
      return Container();
    }

    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        AutoRouter.of(context).push(SettingsRoute());
      },
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
    return Scaffold(
      appBar: buildAppHeader(
        context: context,
        title: Text(kAppName),
        actions: [
          // _SettingsButton(),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Builder(builder: builder)),
          AppFooter(),
        ],
      ),
    );
  }
}
