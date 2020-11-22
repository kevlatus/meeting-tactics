import 'dart:convert' show json;
import 'package:http/http.dart' as http;

import 'models.dart';
import 'repository.dart';

Map<String, String> _getAuthHeaders(String accessToken) {
  return <String, String>{
    "Authorization": "Bearer $accessToken",
    "X-Goog-AuthUser": "0",
  };
}

class _Uris {
  static final _base = Uri(
    scheme: 'https',
    host: 'www.googleapis.com',
    path: '/calendar/v3',
  );

  static Uri listCalendars() => _base.replace(
        pathSegments: [..._base.pathSegments, 'users', 'me', 'calendarList'],
      );

  static Uri listEvents(
    String calendarId, {
    int maxResults = 10,
    DateTime start,
  }) =>
      _base.replace(
        pathSegments: [
          ..._base.pathSegments,
          'calendars',
          calendarId,
          'events'
        ],
        queryParameters: <String, dynamic>{
          'maxResults': maxResults.toString(),
          'timeMin': (start ?? DateTime(1900)).toUtc().toIso8601String()
        },
      );
}

typedef StringGetter = String Function();

class GoogleCalendarRepository extends CalendarRepository {
  final AccessTokenProvider tokenProvider;

  GoogleCalendarRepository(this.tokenProvider);

  @override
  Future<List<Calendar>> fetchCalendars() async {
    final accessToken = await tokenProvider.accessToken;
    final http.Response response = await http.get(
      _Uris.listCalendars(),
      headers: _getAuthHeaders(accessToken),
    );
    if (response.statusCode != 200) {
      print('${response.statusCode} response: ${response.body}');
      throw Error();
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final items = (data['items'] as List).cast<Map<String, dynamic>>();
    return items
        .map((e) => Calendar(
              e['id'],
              e['summary'],
              primary: e['primary'] ?? false,
              source: 'google',
            ))
        .toList();
  }

  @override
  Future<Calendar> fetchPrimaryCalendar() async {
    final calendars = await fetchCalendars();
    return calendars.firstWhere(
      (element) => element.primary,
      orElse: () => null,
    );
  }

  @override
  Future<List<CalendarEvent>> fetchEvents(
    Calendar calendar, {
    DateTime start,
    DateTime end,
    int maxResults = 10,
  }) async {
    final accessToken = await tokenProvider.accessToken;
    final response = await http.get(
      _Uris.listEvents(
        calendar.id,
        start: start,
      ),
      headers: _getAuthHeaders(accessToken),
    );
    if (response.statusCode != 200) {
      print('${response.statusCode} response: ${response.body}');
      throw Error();
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final items = (data['items'] as List).cast<Map<String, dynamic>>();
    return items
        .map((e) => CalendarEvent(
              id: e['id'],
              title: e['summary'],
              attendees: parseAttendees(e['attendees']),
              start: _parseDate(e['start']),
              end: _parseDate(e['end']),
            ))
        .toList();
  }
}

DateTime _parseDate(Map<String, dynamic> date) {
  return DateTime.parse(date['date'] ?? date['dateTime']);
}

List<EventGuest> parseAttendees(List<dynamic> attendees) {
  return attendees?.map((e) => EventGuest(email: e['email']))?.toList();
}
