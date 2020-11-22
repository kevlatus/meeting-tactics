import 'models.dart';

abstract class CalendarRepository {
  AccessTokenProvider get tokenProvider;

  Future<List<Calendar>> fetchCalendars();

  Future<Calendar> fetchPrimaryCalendar();

  Future<List<CalendarEvent>> fetchEvents(
    Calendar calendar, {
    DateTime start,
    DateTime end,
    int maxResults = 10,
  });

  Future<List<CalendarEvent>> fetchUpcomingEvents(
    Calendar calendar, {
    int maxResults = 10,
  }) {
    return fetchEvents(
      calendar,
      start: DateTime.now(),
      maxResults: maxResults,
    );
  }
}
