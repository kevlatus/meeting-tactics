import 'package:flutter/material.dart';

Future<bool> showConfirmDialog({
  @required BuildContext context,
  @required String title,
  @required String message,
}) async {
  assert(context != null);
  assert(title != null);
  assert(message != null);

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
    content: Text(message),
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
