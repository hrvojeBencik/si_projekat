import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/models/care.dart';

class CareTile extends StatelessWidget {
  const CareTile({Key? key, required this.care}) : super(key: key);

  final Care care;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.local_hospital_outlined,
          color: FructifyColors.darkGreen,
        ),
        const SizedBox(width: 20),
        Text(
          care.type,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          care.quantity,
          style: const TextStyle(
            color: FructifyColors.darkGreen,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          DateFormat('dd.MM.yyyy.').format(care.date),
          style: const TextStyle(
            color: FructifyColors.lightGreen,
          ),
        ),
        const SizedBox(width: 20),
        if (care.comment != null && care.comment != '') Text(care.comment!),
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
