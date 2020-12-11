import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Meeting extends Equatable {
  final List<String> attendees;

  const Meeting({
    this.attendees = const <String>[],
  });

  Meeting copyWith({List<String> attendees}) => Meeting(
        attendees: attendees,
      );

  @override
  List<Object> get props => [attendees];
}
