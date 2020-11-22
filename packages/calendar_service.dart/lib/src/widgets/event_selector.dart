import 'package:calendar_service/calendar_service.dart';
import 'package:flutter/material.dart';

typedef EventCallback = void Function(CalendarEvent);

class EventSelector extends StatelessWidget {
  final List<CalendarEvent> events;
  final EventCallback onSelected;

  EventSelector({
    Key key,
    this.events,
    this.onSelected,
  })  : assert(events.isNotEmpty),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: events.map((event) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              dense: true,
              leading: Icon(Icons.event),
              title: Text(event.title),
//          subtitle: Text('${event.start} - ${event.end}'),
            ),
          );
        }).toList(),
      ),
    );
  }

  static Future<T> asDialog<T>(
    BuildContext context, {
    List<CalendarEvent> events,
    EventCallback onSelected,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return Dialog(
          child: EventSelector(
            events: events,
            onSelected: onSelected,
          ),
        );
      },
    );
  }
}
