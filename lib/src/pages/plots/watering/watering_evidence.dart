import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/bloc/watering/watering_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/pages/plots/watering/new_watering_form.dart';
import 'package:si_app/src/pages/plots/watering/watering_tile.dart';
import 'package:si_app/src/utils/toast.dart';
import 'package:si_app/src/widgets/fructify_loader.dart';

class WateringEvidence extends StatefulWidget {
  const WateringEvidence({Key? key, required this.plotId}) : super(key: key);

  final String plotId;

  @override
  State<WateringEvidence> createState() => _WateringEvidenceState();
}

class _WateringEvidenceState extends State<WateringEvidence> {
  late final WateringBloc _bloc = context.read<WateringBloc>()..add(LoadWateringsEvent(widget.plotId));
  late final AppLocalizations _localization = AppLocalizations.of(context)!;
  bool _isAddingNewOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WateringBloc, WateringState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is NewWateringSuccessfullyAddedState) {
          displayToast(
            message: _localization.newWateringSuccessAdd,
          );
        }

        if (state is NewWateringErrorState) {
          displayToast(
            message: _localization.newWateringError,
            color: FructifyColors.red,
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingWateringsState) {
          return _loadingWaterings();
        }

        if (state is WateringsLoadedState) {
          return Column(
            children: [
              _headerRow(),
              const SizedBox(height: 10),
              if (_isAddingNewOpen)
                NewWateringForm(
                  closeForm: () => setState(() => _isAddingNewOpen = false),
                  plotId: widget.plotId,
                ),
              ...state.waterings.map((e) => WateringTile(watering: e)).toList(),
            ],
          );
        }

        return Text(_localization.genericErrorMessage, style: FructifyStyles.textStyle.errorMessageStyle);
      },
    );
  }

  Column _loadingWaterings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_localization.watering, style: FructifyStyles.textStyle.headerStyle3),
        const SizedBox(height: 20),
        const SizedBox(width: 300, child: FructifyLoader.vertical()),
      ],
    );
  }

  Widget _headerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_localization.watering, style: FructifyStyles.textStyle.headerStyle3),
        if (!_isAddingNewOpen)
          IconButton(
            onPressed: () => setState(() => _isAddingNewOpen = true),
            icon: const Icon(
              Icons.add,
              color: FructifyColors.lightGreen,
            ),
          ),
      ],
    );
  }
}
