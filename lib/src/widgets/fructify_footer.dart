import 'package:flutter/material.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FructifyFooter extends StatelessWidget {
  const FructifyFooter({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 5),
      width: double.infinity,
      color: FructifyColors.white,
      child: Text(
        AppLocalizations.of(context)!.legalRights,
      ),
    );
  }
}
