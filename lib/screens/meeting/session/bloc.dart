import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meet/models/models.dart';
import 'package:meet/screens/meeting/meeting.dart';
import 'package:meet/timer/timer.dart';

enum StepperDirection {
  Forward,
  Backward,
}

class MeetingSessionState extends Equatable {
  final Meeting meeting;
  final List<String> speakerLog;
  final OrderStrategy order;
  final TimerStrategy timer;
  final bool isFinished;
  final StepperDirection direction;

  const MeetingSessionState({
    this.meeting,
    this.isFinished = false,
    this.order = const OrderStrategy.random(),
    this.timer = const NoTimerStrategy(),
    this.speakerLog = const <String>[],
    this.direction,
  });

  int get speakerIndex => meeting != null && speakerLog.isNotEmpty
      ? meeting.attendees.indexOf(speakerLog.last)
      : null;

  bool get hasNextSpeaker => speakerLog.length < meeting.attendees.length;

  bool get hasPreviousSpeaker => speakerLog.isNotEmpty;

  List<String> get previousSpeakers =>
      speakerLog.take(speakerLog.isEmpty ? 0 : speakerLog.length - 1).toList();

  MeetingSessionState copyWith({
    Meeting meeting,
    bool isFinished,
    OrderStrategy order,
    TimerStrategy timer,
    List<String> speakerLog,
    StepperDirection direction,
  }) =>
      MeetingSessionState(
        meeting: meeting ?? this.meeting,
        isFinished: isFinished ?? this.isFinished,
        order: order ?? this.order,
        timer: timer ?? this.timer,
        speakerLog: speakerLog ?? this.speakerLog,
        direction: direction ?? this.direction,
      );

  @override
  List<Object> get props => [meeting, isFinished, order, speakerLog, timer];
}

class MeetingSessionCubit extends Cubit<MeetingSessionState> {
  MeetingSessionCubit() : super(MeetingSessionState());

  void startNewSession(MeetingSetupState setupState) {
    emit(MeetingSessionState(
      meeting: setupState.meeting,
      order: setupState.orderStrategy,
      timer: setupState.timerStrategy,
    ));
  }

  void previousSpeaker() {
    final speakers =
        state.speakerLog.take(state.speakerLog.length - 1).toList();
    emit(state.copyWith(
      speakerLog: speakers,
      direction: StepperDirection.Backward,
    ));
  }

  void nextSpeaker() {
    final next = state.order.next(
      state.speakerLog,
      state.meeting.attendees,
    );
    final speakers = [...state.speakerLog, next];
    emit(state.copyWith(
      speakerLog: speakers,
      direction: StepperDirection.Forward,
    ));
  }

  void resetSpeakers() {
    emit(state.copyWith(
      speakerLog: [],
      direction: StepperDirection.Backward,
    ));
  }

  void finish() {
    emit(state.copyWith(isFinished: true));
  }
}
