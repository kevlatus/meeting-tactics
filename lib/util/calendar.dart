import 'package:calendar_service/calendar_service.dart';

CalendarEvent fillCalendarEvent(CalendarEvent event) {
  return event.copyWith(
    title: event.title == null || event.title.isEmpty
        ? 'Untitled Event' // TODO: use current time to name it "Monday Morning Meeting"
        : event.title,
    attendees: event.attendees ?? <EventGuest>[],
  );
}
