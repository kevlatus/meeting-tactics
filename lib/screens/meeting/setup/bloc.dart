import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meet/models/models.dart';
import 'package:meta/meta.dart';

class SetupError extends Error {
  final int step;
  final String message;

  SetupError({
    this.step,
    @required this.message,
  });
}

@immutable
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

class MeetingSetupCubit extends Cubit<MeetingSetupState> {
  MeetingSetupCubit() : super(MeetingSetupState.initial());

  void error(SetupError error) {
    emit(state.copyWith(error: error));
  }

  void updateAttendees(List<String> guests) {
    emit(
      state.copyWith(
        meeting: state.meeting.copyWith(
          attendees: guests,
        ),
      ),
    );
  }
}
