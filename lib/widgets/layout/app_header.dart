import 'package:flutter/material.dart';

Widget buildAppHeader({
  BuildContext context,
  Widget leading,
  Widget title,
  List<Widget> actions,
}) {
  final theme = Theme.of(context);
  return AppBar(
    leading: leading,
    actions: actions,
    elevation: 2,
    title: DefaultTextStyle(
      style: theme.textTheme.headline6.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      child: title,
    ),
    backgroundColor: theme.colorScheme.surface,
    iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
  );
}
