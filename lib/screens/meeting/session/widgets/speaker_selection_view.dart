import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/screens/meeting/meeting.dart';
import 'package:meet/util/random.dart';
import 'package:meet/widgets/widgets.dart';

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
    final theme = Theme.of(context);
    final fillColor = isUnavailable
        ? Color.alphaBlend(
            theme.disabledColor.withOpacity(0.5),
            theme.colorScheme.surface,
          )
        : null;
    final strokeColor = isUnavailable
        ? Color.alphaBlend(
            theme.disabledColor,
            theme.colorScheme.surface,
          )
        : null;
    final textColor = theme.colorScheme.onPrimary;

    return CircleSlice(
      child: DefaultTextStyle(
        child: Text(attendee),
        style: TextStyle(color: textColor),
      ),
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

    final textAngle = randomInRange(-0.4, 0.4);

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
                  child: Transform.rotate(
                    angle: textAngle,
                    child: CircledBox(
                      child: Text(
                        attendees[selected],
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
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
