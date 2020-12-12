import 'package:flutter/material.dart';

Future<bool> showConfirmDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
}) async {
  assert(context != null);
  assert(title != null);
  assert(content != null);

  Widget cancelButton = FlatButton(
    onPressed: () {
      Navigator.pop(context, false);
    },
    child: Text("CANCEL"),
  );

  Widget confirmButton = RaisedButton(
    onPressed: () {
      Navigator.pop(context, true);
    },
    child: Text("CONFIRM"),
  );

  final dialog = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      cancelButton,
      confirmButton,
    ],
  );

  final result = await showDialog<bool>(
    context: context,
    builder: (context) => dialog,
  );
  return result;
}

Future<Iterable<String>> showItemSelectionDialog({
  @required BuildContext context,
  @required String title,
  @required String message,
  @required Iterable<String> items,
}) async {

  assert(context != null);
  assert(title != null);
  assert(message != null);
  assert(items != null && items.isNotEmpty);

  Widget cancelButton = FlatButton(
    onPressed: () {
      Navigator.pop(context, <String>[]);
    },
    child: Text("CANCEL"),
  );

  Widget confirmButton = RaisedButton(
    onPressed: () {
      Navigator.pop(context, items);
    },
    child: Text("CONFIRM"),
  );

  final dialog = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      cancelButton,
      confirmButton,
    ],
  );

  final result = await showDialog<Iterable<String>>(
    context: context,
    builder: (context) => dialog,
  );
  return result;
}