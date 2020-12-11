import 'package:flutter/material.dart';
import 'package:meet/callbacks.dart';
import 'package:meet/util/util.dart';

import 'guest_list.dart';
import 'name_list_input.dart';

class EditableGuestList extends StatefulWidget {
  final List<String> guests;
  final Callback<List<String>> onChanged;

  EditableGuestList({
    @required this.guests,
    @required this.onChanged,
  }) : assert(guests != null);

  @override
  _EditableGuestListState createState() => _EditableGuestListState();
}

class _EditableGuestListState extends State<EditableGuestList> {
  Future<void> _onSubmitted(Iterable<String> names) async {
    final duplicates =
        widget.guests.map((it) => it).where((it) => names.contains(it)).toSet();
    final nonDuplicates = names.toSet().difference(duplicates);
    if (nonDuplicates.contains('Organizer')) {
      final removeOrganizer = await showConfirmDialog(
        context: context,
        title: "Keyword detected",
        content:
            "The name you entered, seems not to be a name: Organizer. Shall we remove it?",
      );
      if (removeOrganizer) {
        nonDuplicates.removeWhere((it) => it == 'Organizer');
      }
    }

    if (duplicates.isNotEmpty) {
      showWarningSnackbar(
        context: context,
        message:
            'Skipped ${duplicates.length} participants, which are already added to the list.',
      );
    }

    if (widget.onChanged != null) {
      widget.onChanged([
        ...widget.guests,
        ...nonDuplicates,
      ]);
    }
  }

  void _onDelete(String attendee) {
    if (widget.onChanged != null) {
      widget.onChanged(
        widget.guests.where((element) => element != attendee).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NameListInput(
          onSubmitted: _onSubmitted,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: GuestList(
            guests: widget.guests,
            onDelete: _onDelete,
          ),
        ),
      ],
    );
  }
}
