import 'package:flutter/material.dart';

class ParticipantsView extends StatelessWidget {
  final String? name;
  final String? channelId;

  const ParticipantsView({Key? key, this.name, this.channelId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        name ?? '',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      avatar: Icon(Icons.open_in_new_rounded),
    );
  }
}
