import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meet/models/meeting/meeting.dart';

class AppState extends Equatable {
  final MeetingSession meetingSession;

  const AppState({
    this.meetingSession,
  });

  AppState copyWith({
    MeetingSession meetingSession,
  }) =>
      AppState(
        meetingSession: meetingSession ?? this.meetingSession,
      );

  @override
  List<Object> get props => [meetingSession];
}

abstract class _AppEvent extends Equatable {
  const _AppEvent();
}

class UpdateAppStateEvent extends _AppEvent {
  final AppState state;

  const UpdateAppStateEvent(this.state);

  @override
  List<Object> get props => [state];
}

class AppBloc extends Bloc<_AppEvent, AppState> {
  AppBloc() : super(AppState());

  @override
  Stream<AppState> mapEventToState(_AppEvent event) async* {
    if (event is UpdateAppStateEvent) {
      yield event.state;
    }
  }

  void setState(AppState state) {
    add(UpdateAppStateEvent(state));
  }

  void setActiveSession(MeetingSession session) {
    setState(state.copyWith(meetingSession: session));
  }
}
