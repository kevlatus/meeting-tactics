import 'package:flutter/material.dart';
import 'package:meet/models/models.dart';
import 'package:meet/widgets/tactics/callbacks.dart';

class TacticCard extends StatelessWidget {
  final Tactic tactic;
  final TacticCallback onSelected;

  const TacticCard(
    this.tactic, {
    Key key,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        if (onSelected != null) {
          onSelected(tactic);
        }
      },
      child: Card(
        child: Container(
          color: theme.accentColor.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tactic.title,
                  style: theme.textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(height: 16),
                Text(tactic.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
