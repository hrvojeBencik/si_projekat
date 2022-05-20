import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/authentication/authentication_bloc.dart';
import 'package:si_app/src/bloc/plots/bloc/plots_bloc.dart';
import 'package:si_app/src/widgets/fructify_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FructifyButton(
          onClick: () {
            context.read<PlotsBloc>().clearPlotList();
            context.read<AuthenticationBloc>().add(SignOutEvent());
          },
          text: AppLocalizations.of(context)!.logout,
        ),
      ),
    );
  }
}
