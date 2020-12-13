import 'package:flutter/material.dart';
import 'package:meet/widgets/hyperlink.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                // HyperLink(
                //   href: '/privacy',
                //   color: Colors.black,
                //   child: Text('Privacy Policy'),
                // ),
                // HyperLink(
                //   href: '/legal',
                //   color: Colors.black,
                //   child: Text('Legal Notice'),
                // ),
              ],
            ),
          ),
          HyperLink(
            href: 'https://kevlatus.de',
            color: Colors.black,
            decoration: TextDecoration.none,
            child: Text('Made with ♥ by kevlatus'),
          ),
        ],
      ),
    );
  }
}
