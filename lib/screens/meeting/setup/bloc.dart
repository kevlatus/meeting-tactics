import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meet/models/models.dart';
import 'package:meta/meta.dart';

const List<String> _blackList = <String>[
  'Organisator',
  'Organizer',
];

@immutable
abstract class SetupHint extends Equatable {
  final int step;

  const SetupHint({
    this.step,
  });
}

abstract class InvalidNameSetupHint extends SetupHint {
  String get name;
}

class BlacklistHint extends SetupHint implements InvalidNameSetupHint {
  final String name;

  const BlacklistHint({
    @required this.name,
    int step,
  }) : super(step: step);

  @override
  List<Object> get props => [step, name];
}

class DuplicateHint extends SetupHint implements InvalidNameSetupHint {
  final String name;

  const DuplicateHint({
    @required this.name,
    int step,
  }) : super(step: step);

  @override
  List<Object> get props => [step, name];
}

@immutable
class MeetingSetupState extends Equatable {
  final Meeting meeting;
  final OrderStrategy orderStrategy;
  final List<SetupHint> hints;

  const MeetingSetupState({
    this.meeting = const Meeting(),
    this.hints = const <SetupHint>[],
    this.orderStrategy = const OrderStrategy.random(),
  });

  Iterable<SetupHint> getHintsByType(Type type) =>
      hints.where((element) => element.runtimeType == type);

  bool hasHint(Type type) => getHintsByType(type).isNotEmpty;

  MeetingSetupState copyWith({
    Meeting meeting,
    List<SetupHint> hints,
    OrderStrategy orderStrategy,
  }) =>
      MeetingSetupState(
        meeting: meeting ?? this.meeting,
        hints: hints ?? this.hints,
        orderStrategy: orderStrategy ?? this.orderStrategy,
      );

  @override
  List<Object> get props => [meeting, hints, orderStrategy];
}

class MeetingSetupCubit extends Cubit<MeetingSetupState> {
  MeetingSetupCubit() : super(MeetingSetupState());

  void addHints(List<SetupHint> hints) {
    emit(state.copyWith(hints: [
      ...state.hints,
      ...hints,
    ]));
  }

  void dismissHints(Iterable<SetupHint> hints) {
    emit(state.copyWith(
      hints: [
        for (var it in state.hints)
          if (!hints.contains(it)) it
      ],
    ));
  }

  void changeOrderStrategy(OrderStrategy strategy) {
    emit(state.copyWith(orderStrategy: strategy));
  }

  void updateAttendees(Iterable<String> attendees) {
    emit(
      state.copyWith(
        meeting: state.meeting.copyWith(
          attendees: attendees.toList(),
        ),
      ),
    );
  }

  void removeAttendees(Iterable<String> toBeDeleted, {bool keepFirst = false}) {
    Iterable<String> update;
    if (!keepFirst) {
      update = state.meeting.attendees.where((it) => !toBeDeleted.contains(it));
    } else {
      update = <String>[
        for (var entry in state.meeting.attendees.asMap().entries)
          if (!toBeDeleted.contains(entry.value))
            entry.value
          else if (state.meeting.attendees
              .sublist(0, entry.key)
              .where((it) => toBeDeleted.contains(it))
              .isEmpty)
            entry.value
      ];
    }
    updateAttendees(update);
  }

  void addAttendees(Iterable<String> attendees) {
    final newAttendees = <String>[
      ...(state.meeting?.attendees ?? []),
      ...attendees,
    ];

    final newHints = <SetupHint>[];
    final blacklisted = attendees.where((it) => _blackList.contains(it));
    if (blacklisted.isNotEmpty) {
      newHints.addAll([
        for (var it in blacklisted) BlacklistHint(name: it),
      ]);
    }

    final duplicates = [
      for (var entry in newAttendees.asMap().entries)
        if (newAttendees.sublist(entry.key + 1).contains(entry.value))
          entry.value
    ];
    if (duplicates.isNotEmpty) {
      newHints.addAll([
        for (var it in duplicates) DuplicateHint(name: it),
      ]);
    }

    emit(
      state.copyWith(
        meeting: state.meeting.copyWith(attendees: newAttendees),
        hints: [
          ...state.hints,
          ...newHints,
        ],
      ),
    );
  }
}
