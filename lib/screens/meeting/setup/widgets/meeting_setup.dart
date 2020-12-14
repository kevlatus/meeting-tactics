import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:meet/util/util.dart';
import 'package:meet/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc.dart';

class _EventSetupLayout extends HookWidget {
  final Widget child;

  const _EventSetupLayout({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticker = useSingleTickerProvider();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: AnimatedSize(
                vsync: ticker,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: child,
                ),
              ),
            ),
            Image.asset('assets/images/ic-team-spirit.png'),
          ],
        ),
      ),
    );
  }
}

class EventSetup extends StatelessWidget {
  const EventSetup({Key key}) : super(key: key);

  Future<void> _handleInvalidNames(
    BuildContext context,
    Iterable<InvalidNameSetupHint> hints,
    String dialogTitle,
    String dialogMessage, {
    bool keepFirst = false,
  }) async {
    if (hints.isEmpty) return;

    final cubit = context.bloc<MeetingSetupCubit>();
    cubit.dismissHints(hints);

    final names = [for (var hint in hints) hint.name];
    final removeItems = (await showItemSelectionDialog(
          context: context,
          title: dialogTitle,
          message: dialogMessage,
          items: removeDuplicates(names),
        )) ??
        [];

    for (var it in removeItems) {
      cubit.removeAttendees([it], keepFirst: keepFirst);
    }
  }

  Future<void> _handleBlacklist(
    BuildContext context,
    Iterable<BlacklistHint> hints,
  ) async {
    return _handleInvalidNames(
      context,
      hints,
      "Blacklisted value detected",
      "The following values are on our blacklist. Do you want us to remove them?",
    );
  }

  Future<void> _handleDuplicates(
    BuildContext context,
    Iterable<DuplicateHint> hints,
  ) async {
    return _handleInvalidNames(
      context,
      hints,
      "Duplicate values detected",
      "The following values are duplicated. Do you want us to remove them?",
      keepFirst: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final texts = AppLocalizations.of(context);
    final setupCubit = context.bloc<MeetingSetupCubit>();

    return BlocConsumer<MeetingSetupCubit, MeetingSetupState>(
      listener: (context, state) async {
        await _handleBlacklist(
          context,
          state.getHintsByType(BlacklistHint).cast<BlacklistHint>(),
        );

        await _handleDuplicates(
          context,
          state.getHintsByType(DuplicateHint).cast<DuplicateHint>(),
        );
      },
      builder: (context, state) {
        final canContinue = (state.meeting?.attendees?.length ?? 0) > 1;

        return _EventSetupLayout(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Who\'s gonna join you?',
                    style: theme.textTheme.headline6,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(texts.setup_event_description),
              ),
              PasteAwareTextInput(
                onSubmitted: setupCubit.addAttendees,
              ),
              StepperActions.animated(
                canContinue: () => canContinue,
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
