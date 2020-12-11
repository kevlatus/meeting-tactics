import 'package:bloc/bloc.dart';
import 'package:calendar_service/calendar_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meet/models/models.dart';

class SetupError extends Error {
  final int step;
  final String message;

  SetupError({
    this.step,
    @required this.message,
  });
}

class MeetingSetupState extends Equatable {
  final Meeting meeting;
  final SetupError error;

  const MeetingSetupState._({
    this.meeting,
    this.error,
  });

  const MeetingSetupState.initial()
      : meeting = const Meeting(
          attendees: <String>['A', 'B', 'C', 'D'],
        ),
        error = null;

  MeetingSetupState copyWith({
    Meeting meeting,
    SetupError error,
  }) =>
      MeetingSetupState._(
        meeting: meeting ?? this.meeting,
        error: error ?? this.error,
      );

  @override
  List<Object> get props => [meeting, error];
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

  void updateAttendees(List<String> guests) {
    setState(
      state.copyWith(
        meeting: state.meeting.copyWith(
          attendees: guests,
        ),
      ),
    );
  }
}
