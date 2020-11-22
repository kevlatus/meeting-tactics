import 'package:flutter/material.dart';
import 'package:meet/callbacks.dart';

class SpeakerControls extends StatelessWidget {
  final int selected;
  final Callback<int> onChanged;

  void _notify(int value) {
    if (onChanged != null) {
      onChanged(value);
    }
  }

  void _next() {
    _notify(selected + 1);
  }

  void _undo() {
    _notify(selected - 1);
  }

  void _restart() {
    _notify(0);
  }

  bool get canUndo => selected > 0;

  const SpeakerControls({
    Key key,
    @required this.selected,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlatButton.icon(
          icon: Icon(Icons.play_arrow),
          label: Text('NEXT'),
          onPressed: _next,
        ),
        FlatButton.icon(
          icon: Icon(Icons.fast_rewind),
          label: Text('UNDO'),
          onPressed: canUndo ? _undo : null,
        ),
        FlatButton.icon(
          icon: Icon(Icons.skip_previous),
          label: Text('RESTART'),
          onPressed: canUndo ? _restart : null,
        ),
      ],
    );
  }
}
