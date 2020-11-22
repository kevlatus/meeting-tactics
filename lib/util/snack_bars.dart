import 'package:flutter/material.dart';

Future<void> showSnackBar({
  @required BuildContext context,
  @required String message,
  Color textColor,
  Color backgroundColor,
  Duration duration = const Duration(seconds: 3),
}) async {
  assert(context != null);
  assert(message != null);
  assert(textColor != null);
  assert(backgroundColor != null);
  assert(duration != null);

  final scaffold = Scaffold.of(context);
  final textTheme = Theme.of(context).textTheme.bodyText2;
  final snackBar = scaffold.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: textTheme.copyWith(
          color: textColor,
        ),
      ),
      backgroundColor: backgroundColor,
    ),
  );
  await Future.delayed(duration);
  snackBar.close();
}

Future<void> showWarningSnackbar({
  @required BuildContext context,
  @required String message,
}) async {
  return showSnackBar(
    context: context,
    message: message,
    backgroundColor: Colors.amber,
    textColor: Colors.black,
  );
}

Future<void> showErrorSnackbar({
  @required BuildContext context,
  @required String message,
}) async {
  return showSnackBar(
    context: context,
    message: message,
    backgroundColor: Colors.red,
    textColor: Colors.black,
  );
}
