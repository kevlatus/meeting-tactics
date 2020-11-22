import 'package:flutter/material.dart';
import 'package:meet/models/models.dart';

import 'callbacks.dart';
import 'tactic_card.dart';

class TacticsList extends StatelessWidget {
  final List<Tactic> tactics;
  final TacticCallback onSelected;

  const TacticsList(
    this.tactics, {
    Key key,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tactics.length,
      itemBuilder: (context, index) {
        return TacticCard(
          tactics[index],
          onSelected: (spice) {
            if (onSelected != null) {
              onSelected(spice);
            }
          },
        );
      },
    );
  }
}
