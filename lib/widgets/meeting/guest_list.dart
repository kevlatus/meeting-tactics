import 'package:calendar_service/calendar_service.dart';
import 'package:flutter/material.dart';
import 'package:meet/callbacks.dart';

class GuestList extends StatelessWidget {
  final List<EventGuest> guests;
  final Callback<EventGuest> onDelete;

  const GuestList({
    Key key,
    @required this.guests,
    this.onDelete,
  })  : assert(guests != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: guests.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(guests[index].email ?? guests[index].name ?? ''),
          trailing: onDelete != null
              ? IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    onDelete(guests[index]);
                  },
                )
              : null,
        );
      },
    );
  }
}
