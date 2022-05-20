import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';
import 'package:si_app/src/widgets/fructify_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (context.read<UserRepository>().checkIfVerified()) {
        context.read<AuthenticationBloc>().add(GoToHomePageEvent());
        timer.cancel();
      }
    });

    return LayoutBuilder(builder: (contex, constraints) {
      if (constraints.maxWidth <= 1000) return _mobileLayout(context, constraints.maxWidth);
      return _desktopLayout(context, constraints.maxWidth);
    });
  }

  Widget _desktopLayout(BuildContext context, double screenWidth) {
    return Container(
      width: 1000,
      height: 600,
      margin: const EdgeInsets.all(100),
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 60,
      ),
      decoration: BoxDecoration(
        color: FructifyColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(15, 15),
            blurRadius: 4,
            color: FructifyColors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.successfulRegistration,
            style: FructifyStyles.textStyle.headerStyle2,
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.successfulRegistrationMessage,
            style: FructifyStyles.textStyle.messageStyle,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.getNewVerificationMail,
                      style: const TextStyle(
                        color: FructifyColors.darkGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FructifyButton(
                      text: AppLocalizations.of(context)!.sendAgain,
                      onClick: () {
                        context.read<AuthenticationBloc>().add(SendVerificationMailEvent());
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/verification_mail.png',
                  height: 300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mobileLayout(BuildContext context, double screenWidth) {
    return Container(
      width: screenWidth * 0.95,
      height: 600,
      margin: const EdgeInsets.only(top: 100),
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 60,
      ),
      decoration: BoxDecoration(
        color: FructifyColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(15, 15),
            blurRadius: 4,
            color: FructifyColors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.successfulRegistration,
            style: FructifyStyles.textStyle.headerStyle2,
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.successfulRegistrationMessage,
            style: FructifyStyles.textStyle.messageStyle,
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.getNewVerificationMail,
            style: const TextStyle(
              color: FructifyColors.darkGreen,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          FructifyButton(
            text: AppLocalizations.of(context)!.sendAgain,
            onClick: () {
              context.read<AuthenticationBloc>().add(SendVerificationMailEvent());
            },
          ),
        ],
      ),
    );
  }
}
