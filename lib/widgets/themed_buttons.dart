import 'package:flutter/material.dart';

class PrimaryRaisedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const PrimaryRaisedButton({
    Key key,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RaisedButton(
      onPressed: onPressed,
      child: child,
      color: theme.primaryColor,
      textColor: Colors.white,
    );
  }
}

class PrimaryFlatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const PrimaryFlatButton({
    Key key,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FlatButton(
      onPressed: onPressed,
      child: child,
      textColor: theme.primaryColor,
    );
  }
}

class PrimaryOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const PrimaryOutlineButton({
    Key key,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlineButton(
      onPressed: onPressed,
      child: child,
      textColor: theme.primaryColor,
      splashColor: theme.primaryColor.withOpacity(0.3),
    );
  }
}
