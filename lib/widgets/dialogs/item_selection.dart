import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class _ItemSelectionDialog extends HookWidget {
  final String title;
  final String message;
  final List<String> items;

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

    bool isSelected(String item) => selected.value.contains(item);

    void selectItem(String item) {
      selected.value = [...selected.value, item];
    }

    void deselectItem(String item) {
      selected.value = [
        for (var it in selected.value)
          if (it != item) it
      ];
    }

    Widget cancelButton = FlatButton(
      onPressed: () {
        Navigator.pop(context, <String>[]);
      },
      child: Text("CANCEL"),
    );

    Widget confirmButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context, selected.value);
      },
      child: Text("CONFIRM"),
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
                final item = items[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(items[index]),
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
        cancelButton,
        confirmButton,
      ],
    );
  }
}

Future<Iterable<String>> showItemSelectionDialog({
  @required BuildContext context,
  @required String title,
  @required String message,
  @required List<String> items,
}) async {
  assert(context != null);

  final result = await showDialog<Iterable<String>>(
    context: context,
    builder: (context) => _ItemSelectionDialog(
      title: title,
      message: message,
      items: items,
    ),
  );
  return result;
}
