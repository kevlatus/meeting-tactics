import 'package:flutter/cupertino.dart';

class Tactic {
  final String title;
  final String description;

  Tactic({
    @required this.title,
    @required this.description,
  })  : assert(title != null),
        assert(description != null);
}
