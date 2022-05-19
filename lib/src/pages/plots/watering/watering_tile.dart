import 'package:flutter/material.dart';
import 'package:si_app/src/bloc/watering/watering_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/models/watering.dart';

class WateringTile extends StatelessWidget {
  const WateringTile({Key? key, required this.watering, required this.bloc}) : super(key: key);

  final Watering watering;
  final WateringBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.water_drop_outlined,
          color: FructifyColors.darkGreen,
        ),
        const SizedBox(width: 20),
        Text(
          watering.type,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 20),
        if (watering.comment != null && watering.comment != '') Text(watering.comment!),
        const Spacer(),
        IconButton(
          onPressed: () {
            bloc.add(RemoveWateringEvent(watering));
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
