import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/models/yield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YieldTile extends StatelessWidget {
  const YieldTile({Key? key, required this.yield}) : super(key: key);

  final Yield yield;

  @override
  Widget build(BuildContext context) {
    final bool _isExpense = yield.income == '';

    return Row(
      children: [
        Icon(
          Icons.monetization_on_outlined,
          color: _isExpense ? FructifyColors.red : FructifyColors.darkGreen,
        ),
        const SizedBox(width: 20),
        Text(
          _isExpense ? '-${yield.expense}' : '+${yield.income}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          _isExpense ? yield.comment ?? '' : AppLocalizations.of(context)!.yieldAmount + ': ' + yield.amount,
          style: const TextStyle(
            color: FructifyColors.darkGreen,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          DateFormat('dd.MM.yyyy.').format(yield.date),
          style: const TextStyle(
            color: FructifyColors.lightGreen,
          ),
        ),
        const SizedBox(width: 20),
        if (!_isExpense) Text(yield.comment ?? ''),
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
