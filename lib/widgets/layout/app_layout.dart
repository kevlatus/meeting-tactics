import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meet/constants.dart';
import 'package:router_v2/router_v2.dart';

import 'app_footer.dart';

class AppLayout extends StatelessWidget {
  final WidgetBuilder builder;

  const AppLayout({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = Router.of(context);

    final settingsButton = router.isActive('/settings')
        ? Container()
        : IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Router.of(context).push('/settings');
            },
          );

    return Scaffold(
      appBar: AppBar(
        title: Text(kAppName),
        // actions: [settingsButton],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([Builder(builder: builder)]),
          ),
          // SliverFillRemaining(
          //   hasScrollBody: false,
          //   child: Column(
          //     children: [
          //       Expanded(child: Container()),
          //       AppFooter(),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
