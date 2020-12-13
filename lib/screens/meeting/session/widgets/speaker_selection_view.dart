import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/screens/meeting/meeting.dart';

class SpeakerSelectionView extends HookWidget {
  final int selected;
  final List<String> attendees;
  final List<String> unavailableAttendees;
  final VoidCallback onAnimationStart;
  final VoidCallback onAnimationEnd;
  final StepperDirection direction;

  const SpeakerSelectionView({
    Key key,
    @required this.attendees,
    this.selected,
    this.onAnimationStart,
    this.onAnimationEnd,
    this.unavailableAttendees = const <String>[],
    this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selected == null) {
      return Container();
    }

    return _FortuneWheelSpeakerSelection(
      attendees: attendees,
      selected: selected,
      onAnimationStart: onAnimationStart,
      onAnimationEnd: onAnimationEnd,
      direction: direction,
      unavailableAttendees: unavailableAttendees,
    );
  }
}

class _FortuneWheelSpeakerSelection extends HookWidget {
  static const Interval _kRollInterval = const Interval(0, 0.7);

  final int selected;
  final List<String> attendees;
  final List<String> unavailableAttendees;
  final VoidCallback onAnimationStart;
  final VoidCallback onAnimationEnd;
  final StepperDirection direction;

  CircleSlice _buildCircleSlice(BuildContext context, String attendee) {
    final isUnavailable = unavailableAttendees.contains(attendee);
    final fillColor = isUnavailable ? Colors.grey.shade400 : null;
    final strokeColor = isUnavailable ? Colors.grey.shade600 : null;

    return CircleSlice(
      child: Text(attendee),
      fillColor: fillColor,
      strokeColor: strokeColor,
    );
  }

  const _FortuneWheelSpeakerSelection({
    Key key,
    @required this.attendees,
    @required this.selected,
    this.onAnimationStart,
    this.onAnimationEnd,
    this.unavailableAttendees = const <String>[],
    this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationCtrl = useAnimationController(
      duration: Duration(milliseconds: 500),
    );

    useValueChanged(selected, (_, __) {
      animationCtrl.reverse(from: _kRollInterval.end);
    });

    final rollAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: _kRollInterval,
      ),
    );
    final resultAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationCtrl,
        curve: Interval(_kRollInterval.end, 1),
      ),
    );

    final animationType = direction == StepperDirection.Backward
        ? FortuneWheelAnimation.None
        : FortuneWheelAnimation.Roll;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 512,
        maxHeight: 512,
      ),
      child: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: animationCtrl,
              builder: (context, _) {
                return Transform.scale(
                  scale: resultAnimation.value,
                  child: Text(attendees[selected]),
                );
              },
            ),
            AnimatedBuilder(
              animation: animationCtrl,
              builder: (context, _) {
                return Transform.scale(
                  scale: rollAnimation.value,
                  child: FortuneWheel(
                    selected: selected,
                    animation: animationType,
                    onAnimationStart: onAnimationStart,
                    onAnimationEnd: () async {
                      // await Future.delayed(Duration(milliseconds: 100));
                      animationCtrl.forward();
                      if (onAnimationEnd != null) {
                        onAnimationEnd();
                      }
                    },
                    slices: [
                      for (String attendee in attendees)
                        _buildCircleSlice(context, attendee)
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
