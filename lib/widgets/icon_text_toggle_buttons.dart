import 'package:flutter/material.dart';
import 'package:meet/callbacks.dart';

class IconTextToggleButton<T> extends StatelessWidget {
  final Icon icon;
  final String text;
  final T value;

  const IconTextToggleButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 96),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: icon,
          ),
          Text(text),
        ],
      ),
    );
  }
}

class IconTextToggleButtons<T> extends StatelessWidget {
  final T selected;
  final List<IconTextToggleButton<T>> items;
  final Predicate<T> matcher;
  final Callback<T> onChanged;

  IconTextToggleButtons({
    Key key,
    this.selected,
    @required this.items,
    Predicate<T> matcher,
    this.onChanged,
  })  : matcher = matcher ?? ((v) => v == selected),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(4),
      isSelected: [for (var it in items) matcher(it.value)],
      children: items,
      onPressed: (int index) {
        if (onChanged != null) {
          onChanged(items[index].value);
        }
      },
    );
  }
}
