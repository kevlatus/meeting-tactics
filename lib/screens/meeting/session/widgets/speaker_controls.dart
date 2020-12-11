import 'package:flutter/material.dart';
import 'package:meet/util/util.dart';
import 'package:provider/provider.dart';

import '../bloc.dart';

class SpeakerControls extends StatelessWidget {
  final bool disabled;

  Widget _buildNextButton(
    BuildContext context,
    MeetingSessionCubit meetingSession,
  ) {
    final canNext = !disabled && meetingSession.state.hasNextSpeaker;
    final canFinish = !disabled && !meetingSession.state.hasNextSpeaker;

    if (canFinish) {
      return FlatButton.icon(
        icon: Icon(Icons.play_arrow),
        label: Text('FINISH'),
        onPressed: canFinish ? meetingSession.finish : null,
      );
    }

    return FlatButton.icon(
      icon: Icon(Icons.play_arrow),
      label: Text('NEXT'),
      onPressed: canNext ? meetingSession.nextSpeaker : null,
    );
  }

  const SpeakerControls({
    Key key,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meetingSession = Provider.of<MeetingSessionCubit>(context);

    final canNext = !disabled && meetingSession.state.hasNextSpeaker;
    final canFinish = !disabled && !meetingSession.state.hasNextSpeaker;
    final canUndo = !disabled && meetingSession.state.hasPreviousSpeaker;

    final startButton = TextButton.icon(
      icon: Icon(Icons.play_arrow),
      label: Text('START'),
      onPressed: meetingSession.nextSpeaker,
    );

    final nextButton = TextButton.icon(
      icon: Icon(Icons.fast_forward),
      label: Text('NEXT'),
      onPressed: canNext ? meetingSession.nextSpeaker : null,
    );

    final finishButton = TextButton.icon(
      icon: Icon(Icons.check),
      label: Text('FINISH'),
      onPressed: canFinish ? meetingSession.finish : null,
    );

    final undoButton = TextButton.icon(
      style: TextButton.styleFrom(primary: Colors.black),
      icon: Icon(Icons.fast_rewind),
      label: Text('UNDO'),
      onPressed: canUndo ? meetingSession.previousSpeaker : null,
    );

    final restartButton = TextButton.icon(
      style: TextButton.styleFrom(primary: Colors.black),
      icon: Icon(Icons.skip_previous),
      label: Text('RESTART'),
      onPressed: canUndo ? meetingSession.resetSpeakers : null,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: withPadding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        children: [
          if (!meetingSession.state.hasPreviousSpeaker)
            startButton
          else if (canFinish)
            finishButton
          else
            nextButton,
          undoButton,
          restartButton,
        ],
      ),
    );
  }
}
