import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/models/tillage.dart';

class TillageTile extends StatelessWidget {
  const TillageTile({Key? key, required this.tillage}) : super(key: key);

  final Tillage tillage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.agriculture_outlined,
          color: FructifyColors.darkGreen,
        ),
        const SizedBox(width: 20),
        Text(
          tillage.type,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          DateFormat('dd.MM.yyyy.').format(tillage.date),
          style: const TextStyle(
            color: FructifyColors.lightGreen,
          ),
        ),
        const SizedBox(width: 20),
        if (tillage.comment != null && tillage.comment != '') Text(tillage.comment!),
        const Spacer(),
        IconButton(
          onPressed: () {
            // Delete entry
          },
          icon: const Icon(
            Icons.delete,
            color: FructifyColors.red,
          ),
        ),
      ],
    );
  }
}
