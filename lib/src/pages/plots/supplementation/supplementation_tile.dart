import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/models/supplementation.dart';

class SupplementationTile extends StatelessWidget {
  const SupplementationTile({Key? key, required this.supplementation}) : super(key: key);

  final Supplementation supplementation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.forest_outlined,
          color: FructifyColors.darkGreen,
        ),
        const SizedBox(width: 20),
        Text(
          supplementation.type,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          supplementation.quantity,
          style: const TextStyle(
            color: FructifyColors.darkGreen,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          DateFormat('dd.MM.yyyy.').format(supplementation.date),
          style: const TextStyle(
            color: FructifyColors.lightGreen,
          ),
        ),
        const SizedBox(width: 20),
        if (supplementation.comment != null && supplementation.comment != '') Text(supplementation.comment!),
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
