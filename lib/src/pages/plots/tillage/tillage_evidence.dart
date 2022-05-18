import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/tillage/tillage_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/pages/plots/tillage/new_tillage_form.dart';
import 'package:si_app/src/pages/plots/tillage/tillage_tile.dart';
import 'package:si_app/src/utils/toast.dart';
import 'package:si_app/src/widgets/fructify_loader.dart';

class TillageEvidence extends StatefulWidget {
  const TillageEvidence({Key? key, required this.plotId}) : super(key: key);

  final String plotId;

  @override
  State<TillageEvidence> createState() => _TillageEvidenceState();
}

class _TillageEvidenceState extends State<TillageEvidence> {
  late final TillageBloc _bloc = context.read<TillageBloc>()..add(LoadTillagesEvent(widget.plotId));
  late final AppLocalizations _localization = AppLocalizations.of(context)!;
  bool _isAddingNewOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TillageBloc, TillageState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is NewTillageSuccessfullyAddedState) {
          displayToast(
            message: _localization.newTillageSuccessAdd,
          );
        }

        if (state is NewTillageErrorState) {
          displayToast(
            message: _localization.newTillageError,
            color: FructifyColors.red,
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingTillagesState) {
          return _loadingTillages();
        }

        if (state is TillagesLoadedState) {
          return Column(
            children: [
              _headerRow(),
              const SizedBox(height: 10),
              if (_isAddingNewOpen)
                NewTillageForm(
                  closeForm: () => setState(() => _isAddingNewOpen = false),
                  plotId: widget.plotId,
                ),
              // Tillage Tiles
              ...state.tillages.map((e) => TillageTile(tillage: e)).toList()
            ],
          );
        }

        return Text(_localization.genericErrorMessage, style: FructifyStyles.textStyle.errorMessageStyle);
      },
    );
  }

  Column _loadingTillages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_localization.tillage, style: FructifyStyles.textStyle.headerStyle3),
        const SizedBox(height: 20),
        const SizedBox(width: 300, child: FructifyLoader.vertical()),
      ],
    );
  }

  Widget _headerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_localization.tillage, style: FructifyStyles.textStyle.headerStyle3),
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
