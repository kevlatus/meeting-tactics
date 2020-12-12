import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meet/models/models.dart';

enum StepperDirection {
  Forward,
  Backward,
}

class MeetingSessionState extends Equatable {
  final Meeting meeting;
  final List<String> selectedSpeakers;
  final OrderStrategy orderStrategy;
  final bool isFinished;
  final StepperDirection direction;

  const MeetingSessionState({
    this.meeting,
    this.isFinished = false,
    this.orderStrategy = const OrderStrategy.fixed(),
    this.selectedSpeakers = const <String>[],
    this.direction,
  });

  int get selectedSpeakerIndex => meeting != null && selectedSpeakers.isNotEmpty
      ? meeting.attendees.indexOf(selectedSpeakers.last)
      : null;

  bool get hasNextSpeaker => selectedSpeakers.length < meeting.attendees.length;

  bool get hasPreviousSpeaker => selectedSpeakers.isNotEmpty;

  MeetingSessionState copyWith({
    Meeting meeting,
    bool isFinished,
    OrderStrategy orderStrategy,
    List<String> selectedSpeakers,
    StepperDirection direction,
  }) =>
      MeetingSessionState(
        meeting: meeting ?? this.meeting,
        isFinished: isFinished ?? this.isFinished,
        orderStrategy: orderStrategy ?? this.orderStrategy,
        selectedSpeakers: selectedSpeakers ?? this.selectedSpeakers,
        direction: direction ?? this.direction,
      );

  @override
  List<Object> get props =>
      [meeting, isFinished, orderStrategy, selectedSpeakers];
}

class MeetingSessionCubit extends Cubit<MeetingSessionState> {
  MeetingSessionCubit() : super(MeetingSessionState());

  void startNewSession(Meeting meeting) {
    emit(MeetingSessionState(meeting: meeting));
  }

  void previousSpeaker() {
    final speakers =
        state.selectedSpeakers.take(state.selectedSpeakers.length - 1).toList();
    emit(state.copyWith(
      selectedSpeakers: speakers,
      direction: StepperDirection.Backward,
    ));
  }

  void nextSpeaker() {
    final next = state.orderStrategy.next(
      state.selectedSpeakers,
      state.meeting.attendees,
    );
    final speakers = [...state.selectedSpeakers, next];
    emit(state.copyWith(
      selectedSpeakers: speakers,
      direction: StepperDirection.Forward,
    ));
  }

  void resetSpeakers() {
    emit(state.copyWith(
      selectedSpeakers: [],
      direction: StepperDirection.Backward,
    ));
  }

  void finish() {
    emit(state.copyWith(isFinished: true));
  }
}
