import 'package:bloc/bloc.dart';
import 'package:calendar_service/calendar_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class SetupError extends Error {
  final int step;
  final String message;

  SetupError({
    this.step,
    @required this.message,
  });
}

class MeetingSetupState extends Equatable {
  final CalendarEvent calendarEvent;
  final SetupError error;

  const MeetingSetupState._({
    this.calendarEvent,
    this.error,
  });

  const MeetingSetupState.initial()
      : calendarEvent = const CalendarEvent(
          attendees: <EventGuest>[
            EventGuest(name: 'A'),
            EventGuest(name: 'B'),
            EventGuest(name: 'C'),
            EventGuest(name: 'D'),
          ],
        ),
        error = null;

  MeetingSetupState copyWith({
    CalendarEvent calendarEvent,
    SetupError error,
  }) =>
      MeetingSetupState._(
        calendarEvent: calendarEvent ?? this.calendarEvent,
        error: error ?? this.error,
      );

  @override
  List<Object> get props => [calendarEvent, error];
}

abstract class MeetingSetupEvent extends Equatable {}

class UpdateMeetingSetupEvent extends MeetingSetupEvent {
  final MeetingSetupState state;

  UpdateMeetingSetupEvent(this.state);

  @override
  List<Object> get props => [state];
}

class MeetingSetupBloc extends Bloc<MeetingSetupEvent, MeetingSetupState> {
  MeetingSetupBloc() : super(MeetingSetupState.initial());

  @override
  Stream<MeetingSetupState> mapEventToState(MeetingSetupEvent event) async* {
    if (event is UpdateMeetingSetupEvent) {
      yield event.state;
    }
  }

  void setState(MeetingSetupState state) {
    add(UpdateMeetingSetupEvent(state));
  }

  void error(SetupError error) {
    setState(state.copyWith(error: error));
  }

  void updateGuestList(List<EventGuest> guests) {
    setState(
      state.copyWith(
        calendarEvent: state.calendarEvent.copyWith(
          attendees: guests,
        ),
      ),
    );
  }
}
