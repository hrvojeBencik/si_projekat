import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/bloc/supplementation/supplementation_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/pages/plots/supplementation/new_supplementation_form.dart';
import 'package:si_app/src/pages/plots/supplementation/supplementation_tile.dart';
import 'package:si_app/src/services/api_service.dart';
import 'package:si_app/src/utils/toast.dart';
import 'package:si_app/src/widgets/fructify_vertical_loader.dart';

class SupplementationEvidence extends StatefulWidget {
  const SupplementationEvidence({Key? key, required this.plotId}) : super(key: key);

  final String plotId;

  @override
  State<SupplementationEvidence> createState() => _SupplementationEvidenceState();
}

class _SupplementationEvidenceState extends State<SupplementationEvidence> {
  late final SupplementationBloc _bloc = SupplementationBloc(ApiService())..add(LoadSupplementationsEvent(widget.plotId));
  late final AppLocalizations _localization = AppLocalizations.of(context)!;
  bool _isAddingNewOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupplementationBloc, SupplementationState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is NewSupplementationSuccessfullyAddedState) {
          displayToast(
            message: _localization.newSupplementationSuccessAdd,
          );
        }

        if (state is NewSupplementationErrorState) {
          displayToast(
            message: _localization.newSupplementationError,
            color: FructifyColors.red,
          );
        }

        if (state is SuccessfullDelete) {
          displayToast(
            message: _localization.successfulDelete,
            color: FructifyColors.red,
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingSupplementationsState) {
          return FructifyVerticalLoader(
            title: _localization.supplementation,
          );
        }

        if (state is SupplementationsLoadedState) {
          return Column(
            children: [
              _headerRow(),
              const SizedBox(height: 10),
              if (_isAddingNewOpen)
                NewSupplementationForm(
                  closeForm: () => setState(() => _isAddingNewOpen = false),
                  plotId: widget.plotId,
                  bloc: _bloc,
                ),
              ...state.supplementations
                  .map((e) => SupplementationTile(
                        supplementation: e,
                        bloc: _bloc,
                      ))
                  .toList()
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
        Text(_localization.supplementation, style: FructifyStyles.textStyle.headerStyle3),
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
