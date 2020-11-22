import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

class EventGuest {
  final String email;
  final String name;

  const EventGuest({this.email, this.name});

  String get display => this.name ?? this.email;

  @override
  int get hashCode => hash2(email, name);

  @override
  bool operator ==(Object other) {
    return other is EventGuest && email == other.email && name == other.name;
  }
}

class Calendar {
  final String id;
  final bool primary;
  final String source;
  final String title;

  const Calendar(
    this.id,
    this.title, {
    this.primary = false,
    this.source,
  });

  @override
  String toString() => 'Calendar $id (primary: $primary) from $source';

  @override
  int get hashCode => hash4(id, title, primary, source);

  @override
  bool operator ==(Object other) {
    return other is Calendar &&
        id == other.id &&
        primary == other.primary &&
        source == other.source &&
        title == other.title;
  }
}

class CalendarEvent {
  final String id;
  final String title;
  final DateTime start;
  final DateTime end;
  final List<EventGuest> attendees;

  const CalendarEvent({
    this.id,
    this.title,
    this.start,
    this.end,
    this.attendees,
  });

  CalendarEvent copyWith({
    String id,
    String title,
    DateTime start,
    DateTime end,
    List<EventGuest> attendees,
  }) =>
      CalendarEvent(
        id: id ?? this.id,
        title: title ?? this.title,
        start: start ?? this.start,
        end: end ?? this.end,
        attendees: attendees ?? this.attendees,
      );

  @override
  String toString() =>
      'CalendarEvent { title: $title, start: $start, end: $end }';

  @override
  int get hashCode => hashObjects([id, title, start, end, attendees]);

  @override
  bool operator ==(Object other) {
    return other is CalendarEvent &&
        id == other.id &&
        title == other.title &&
        start == other.start &&
        end == other.end &&
        listEquals(attendees, other.attendees);
  }
}

abstract class AccessTokenProvider {
  Future<String> get accessToken;
}
