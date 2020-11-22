import 'package:flutter/material.dart';
import 'package:meet/widgets/widgets.dart';
import 'package:router_v2/router_v2.dart';

class TacticsBox extends StatelessWidget {
  const TacticsBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Browse all tactics',
            style: theme.textTheme.headline6,
          ),
          Container(height: 8),
          Wrap(
            children: [
              FlatButton(
                onPressed: () {
                  Router.of(context).push('/meeting/setup');
                },
                child: Text('Meeting Setup'),
              ),
              FlatButton(
                onPressed: () {
                  Router.of(context).push('/meeting/session');
                },
                child: Text('Meeting Session'),
              ),
              FlatButton(
                onPressed: () {
                  Router.of(context).push('/tactics');
                },
                child: Text('Tactics'),
              ),
              FlatButton(
                onPressed: () {
                  Router.of(context).push('/signin');
                },
                child: Text('Sign In'),
              ),
              FlatButton(
                onPressed: () {
                  Router.of(context).push('/404');
                },
                child: Text('Unknown'),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 368),
            child: TacticsList(
              [],
              onSelected: (tactic) {
                // context
                //     .read<Router>()
                //     .navigateTo(context, '/spices/${spice.id}');
              },
            ),
          )
        ],
      ),
    );
  }
}
