import 'package:flutter/material.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FructifyAppBar extends StatelessWidget implements PreferredSize {
  const FructifyAppBar({Key? key, required this.onClick}) : super(key: key);

  final Function(int index) onClick;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: FructifyColors.whiteGreen,
      title: Padding(
        padding: const EdgeInsets.only(left: 60),
        child: Image.asset(
          'assets/images/fructify-logo.png',
          width: 100,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => onClick(0),
          child: Row(
            children: [
              const Icon(
                Icons.home,
                color: FructifyColors.darkGreen,
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.home,
                style: const TextStyle(color: FructifyColors.darkGreen),
              ),
            ],
          ),
          style: TextButton.styleFrom(
            primary: FructifyColors.lightGreen,
          ),
        ),
        const SizedBox(width: 30),
        TextButton(
          onPressed: () => onClick(1),
          child: Row(
            children: [
              const Icon(
                Icons.settings,
                color: FructifyColors.darkGreen,
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.settings,
                style: const TextStyle(color: FructifyColors.darkGreen),
              ),
            ],
          ),
          style: TextButton.styleFrom(
            primary: FructifyColors.lightGreen,
          ),
        ),
        const SizedBox(width: 60)
      ],
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
