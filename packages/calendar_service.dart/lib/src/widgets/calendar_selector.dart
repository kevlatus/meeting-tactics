import 'package:flutter/material.dart';

import '../models.dart';

typedef CalendarsCallback = void Function(List<Calendar>);

class CalendarSelector extends StatelessWidget {
  final List<Calendar> selected;
  final List<Calendar> calendars;
  final CalendarsCallback onChanged;

  const CalendarSelector({
    Key key,
    @required this.selected,
    @required this.calendars,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: calendars.length,
      itemBuilder: (context, index) {
        var textTheme = Theme.of(context).textTheme.bodyText2;
        if (calendars[index].primary) {
          textTheme = textTheme.copyWith(fontWeight: FontWeight.bold);
        }
        return ListTile(
          title: Text(calendars[index].title, style: textTheme),
        );
      },
    );
  }
}
