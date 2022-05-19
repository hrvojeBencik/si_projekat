import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/bloc/yield/yield_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/pages/plots/yield/new_yield_form.dart';
import 'package:si_app/src/pages/plots/yield/yield_tile.dart';
import 'package:si_app/src/services/api_service.dart';
import 'package:si_app/src/utils/toast.dart';
import 'package:si_app/src/widgets/fructify_vertical_loader.dart';

class YieldEvidence extends StatefulWidget {
  const YieldEvidence({Key? key, required this.plotId}) : super(key: key);

  final String plotId;

  @override
  State<YieldEvidence> createState() => _YieldEvidenceState();
}

class _YieldEvidenceState extends State<YieldEvidence> {
  late final YieldBloc _bloc = YieldBloc(ApiService())..add(LoadYieldsEvent(widget.plotId));
  late final AppLocalizations _localization = AppLocalizations.of(context)!;
  bool _isAddingNewOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<YieldBloc, YieldState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is NewYieldSuccessfullyAddedState) {
          displayToast(
            message: _localization.newYieldSuccessAdd,
          );
        }

        if (state is NewYieldErrorState) {
          displayToast(
            message: _localization.newYieldError,
            color: FructifyColors.red,
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingYieldsState) {
          return FructifyVerticalLoader(
            title: _localization.yield,
          );
        }

        if (state is YieldsLoadedState) {
          return Column(
            children: [
              _headerRow(),
              const SizedBox(height: 10),
              if (_isAddingNewOpen)
                NewYieldForm(
                  closeForm: () => setState(() => _isAddingNewOpen = false),
                  plotId: widget.plotId,
                  bloc: _bloc,
                ),
              ...state.yields.map((e) => YieldTile(yield: e)).toList()
            ],
          );
        }

        return Text(_localization.genericErrorMessage, style: FructifyStyles.textStyle.errorMessageStyle);
      },
    );
  }

  Widget _headerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_localization.yield, style: FructifyStyles.textStyle.headerStyle3),
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
