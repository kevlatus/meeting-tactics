import 'package:flutter/material.dart';
import 'package:meet/widgets/widgets.dart';

class TacticsDetailScreen extends StatelessWidget {
  static Page page(String id) {
    return MaterialPage(
      key: ValueKey('TacticsDetailPage $id'),
      child: TacticsDetailScreen(id: id),
    );
  }

  final String id;

  const TacticsDetailScreen({
    Key key,
    @required this.id,
  })  : assert(id != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      builder: (context) {
        return Text('Tactics Detail $id');
      },
    );
  }
}
