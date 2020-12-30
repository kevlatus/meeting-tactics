import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/settings/settings.dart';

class ItemSelectionResult<T> extends Equatable {
  final List<T> items;
  final bool always;

  const ItemSelectionResult(
    this.items, {
    this.always = false,
  });

  @override
  List<Object> get props => [items, always];
}

class _ItemSelectionDialog<T> extends HookWidget {
  final String title;
  final String message;
  final Iterable<T> items;

  const _ItemSelectionDialog({
    @required this.title,
    @required this.message,
    @required this.items,
  })  : assert(title != null),
        assert(message != null),
        assert(items != null && items.length > 0);

  @override
  Widget build(BuildContext context) {
    final selected = useState([...items]);

    bool isSelected(T item) => selected.value.contains(item);

    void selectItem(T item) {
      selected.value = [...selected.value, item];
    }

    void deselectItem(T item) {
      selected.value = [
        for (var it in selected.value)
          if (it != item) it
      ];
    }

    Widget noButton = FlatButton(
      onPressed: () {
        Navigator.pop(context, ItemSelectionResult(<DenyListEntry>[]));
      },
      child: Text("No"),
    );

    Widget yesAlwaysButton = TextButton(
      onPressed: () {
        Navigator.pop(
          context,
          ItemSelectionResult(selected.value, always: true),
        );
      },
      child: Text("Yes, always"),
    );

    Widget yesButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context, ItemSelectionResult(selected.value));
      },
      child: Text("Yes"),
    );

    final size = MediaQuery.of(context).size;
    final listWidth = size.width * 0.7;

    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          SizedBox(height: 8),
          Container(
            width: listWidth,
            height: 36.0 * items.length,
            child: ListView.builder(
              itemCount: items.length,
              itemExtent: 36.0,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = items.elementAt(index);
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(items.elementAt(index).toString()),
                  trailing: Checkbox(
                    value: isSelected(item),
                    onChanged: (value) {
                      if (value) {
                        selectItem(item);
                      } else {
                        deselectItem(item);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        noButton,
        yesAlwaysButton,
        yesButton,
      ],
    );
  }
}

Future<ItemSelectionResult<T>> showItemSelectionDialog<T>({
  @required BuildContext context,
  @required String title,
  @required String message,
  @required Iterable<T> items,
}) async {
  assert(context != null);

  final result = await showDialog<ItemSelectionResult<T>>(
    context: context,
    builder: (context) => _ItemSelectionDialog<T>(
      title: title,
      message: message,
      items: items,
    ),
  );
  return result;
}
