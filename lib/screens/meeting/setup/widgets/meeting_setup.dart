import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/util/util.dart';
import 'package:meet/widgets/widgets.dart';

import '../bloc.dart';
import 'step_layout.dart';

class EventSetup extends StatelessWidget {
  const EventSetup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final setupCubit = context.bloc<MeetingSetupCubit>();

    return BlocConsumer<MeetingSetupCubit, MeetingSetupState>(
      listener: (context, state) async {
        final hints = <InvalidNameSetupHint>[
          ...state.getHintsByType(BlacklistHint),
          ...state.getHintsByType(DuplicateHint),
        ];

        if (hints.isEmpty) return;

        final cubit = context.bloc<MeetingSetupCubit>();
        cubit.dismissHints(hints);

        final names = [for (var hint in hints) hint.name];
        final removeItems = (await showItemSelectionDialog(
              context: context,
              title: 'Hint',
              message: 'We found duplicated and/or blacklisted names. '
                  'Shall we remove them?',
              items: removeDuplicates(names),
            )) ??
            [];

        final duplicatedNames = [for (var it in hints) it.name];

        for (var it in removeItems) {
          cubit.removeAttendees([it], keepFirst: duplicatedNames.contains(it));
        }
      },
      builder: (context, state) {
        final canContinue = (state.meeting?.attendees?.length ?? 0) > 1;

        return StepLayout(
          image: SvgOrPngImage('assets/images/img-undraw-team-spirit.png'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Who\'s gonna join you?',
                style: theme.textTheme.headline6,
              ),
              SizedBox(height: 16),
              Text(
                'First type the names of meeting participants '
                'below. You can also paste them from a spreadsheet or list.',
              ),
              PasteAwareTextInput(
                onSubmitted: setupCubit.addAttendees,
              ),
              Center(
                child: StepperActions.animated(
                  canContinue: () => canContinue,
                ),
              ),
              GuestList(
                guests: state.meeting?.attendees ?? [],
                onDelete: (attendees) =>
                    setupCubit.removeAttendees([attendees]),
              ),
            ],
          ),
        );
      },
    );
  }
}
