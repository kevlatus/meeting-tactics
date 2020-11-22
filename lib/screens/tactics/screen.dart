import 'package:calendar_service/calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:meet/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TacticsScreen extends StatefulWidget {
  static Page page() {
    return MaterialPage(
      key: const ValueKey('TacticsPage'),
      child: const TacticsScreen(),
    );
  }

  const TacticsScreen({Key key}) : super(key: key);

  @override
  _TacticsScreenState createState() => _TacticsScreenState();
}

class _TacticsScreenState extends State<TacticsScreen> {
  List<Calendar> calendars = <Calendar>[];

  @override
  Widget build(BuildContext context) {
    return AppLayout(builder: (context) {
      return Column(
        children: [
          FlatButton(
            child: Text('FETCH'),
            onPressed: () async {
              final calendars = await context
                  .repository<CalendarRepository>()
                  .fetchCalendars();
              setState(() {
                this.calendars = calendars;
              });
            },
          ),
          CalendarSelector(
            selected: [],
            calendars: calendars,
          ),
        ],
      );
    });
  }
}
