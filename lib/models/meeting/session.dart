import 'package:calendar_service/calendar_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'timer.dart';

class MeetingSession extends Equatable {
  final CalendarEvent event;
  final SpeakerTimer timer;

  const MeetingSession({
    @required this.event,
    this.timer = const NoTimer(),
  });

  @override
  List<Object> get props => [event, timer];
}
