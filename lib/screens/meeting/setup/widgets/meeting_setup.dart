import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/settings/settings.dart';
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
        final duplicateHints = state.hints.whereType<DuplicateHint>();
        final denyListHints = state.hints.whereType<DenyListHint>();

        if (duplicateHints.isEmpty && denyListHints.isEmpty) return;

        final cubit = context.bloc<MeetingSetupCubit>();
        cubit.dismissHints(duplicateHints);
        cubit.dismissHints(denyListHints);

        final implicitDenyList = [
          for (var hint in duplicateHints)
            DenyListEntry(hint.name, keepFirst: true),
          for (var hint in denyListHints)
            DenyListEntry(hint.name, keepFirst: false),
        ].toSet();

        final settings = context.repository<SettingsRepository>().meetingSetup;
        final storedDenyList = settings.get().denyList;
        final promptNames = implicitDenyList.difference(storedDenyList);

        final promptResult = promptNames.isEmpty
            ? ItemSelectionResult(List<DenyListEntry>.empty(), always: false)
            : await showItemSelectionDialog(
                context: context,
                title: 'Hint',
                message: 'We found duplicated and/or blocked names. '
                    'Shall we remove them?',
                items: promptNames,
              );

        final removeValues = [
          ...storedDenyList,
          ...promptResult.items,
        ];

        for (var it in removeValues) {
          cubit.removeAttendees([it.name], keepFirst: it.keepFirst);
        }

        if (promptResult.always) {
          settings.addToDenyList(promptResult.items);
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
