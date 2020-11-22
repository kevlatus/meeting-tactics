import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:router_v2/router_v2.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Home'),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Router.of(context).push('/second');
          },
          child: Text('Navigate'),
        ),
      ],
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('B'),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Router.of(context).push('/redirect');
          },
          child: Text('Redirect'),
        ),
      ],
    );
  }
}

void main() {
  testWidgets('Testidu', (WidgetTester tester) async {
    final routes = <RouteDef>[
      RouteDef(
        path: '/',
        pathMatch: RoutePathMatch.Exact,
        builder: (_) => MaterialPage(
          key: ValueKey('/'),
          child: HomeScreen(),
        ),
      ),
      RouteDef(
        path: '/second',
        builder: (_) => MaterialPage(
          key: ValueKey('/second'),
          child: SecondScreen(),
        ),
      ),
      RouteDef.redirect(
        path: '/redirect',
        redirectTo: '/',
      ),
    ];

    final routerConfig = RouterConfig(
      routes: routes,
      fallbackPath: '/',
    );

    await tester.pumpWidget(MaterialApp.router(
      routeInformationParser: AppRouteInformationParser(routerConfig),
      routerDelegate: AppRouterDelegate(routerConfig),
    ));

    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.text('Navigate'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 10));
    expect(find.text('Home'), findsNothing);
    expect(find.text('B'), findsOneWidget);

    await tester.tap(find.text('Redirect'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 10));
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('B'), findsNothing);
  });
}
