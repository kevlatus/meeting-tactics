import 'package:calendar_service/calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/util/util.dart';
import 'package:meet/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc.dart';

typedef CalendarEventCallback = void Function(CalendarEvent);

class EventSetup extends StatelessWidget {
  const EventSetup({Key key}) : super(key: key);

  void _updateGuestList(BuildContext context, List<EventGuest> guests) {
    context.bloc<MeetingSetupBloc>().updateGuestList(guests);
  }

  bool _onConfirm(BuildContext context, MeetingSetupState state) {
    final guestCount = state?.calendarEvent?.attendees?.length ?? 0;
    if (guestCount < 2) {
      showErrorSnackbar(
        context: context,
        message: AppLocalizations.of(context).error_setup_needMoreGuests,
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final texts = AppLocalizations.of(context);

    return BlocBuilder<MeetingSetupBloc, MeetingSetupState>(
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  texts.setup_event_heading,
                  style: theme.textTheme.headline6,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(texts.setup_event_description),
            ),
            EditableGuestList(
              guests: state.calendarEvent?.attendees ?? [],
              onChanged: (guests) => _updateGuestList(context, guests),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: StepperActions(
                onContinue: () => _onConfirm(context, state),
              ),
            ),
          ],
        );
      },
    );
  }
}
