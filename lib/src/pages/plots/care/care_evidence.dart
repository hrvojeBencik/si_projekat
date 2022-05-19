import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/care/care_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/pages/plots/care/care_tile.dart';
import 'package:si_app/src/pages/plots/care/new_care_form.dart';
import 'package:si_app/src/services/api_service.dart';
import 'package:si_app/src/utils/toast.dart';
import 'package:si_app/src/widgets/fructify_vertical_loader.dart';

class CareEvidence extends StatefulWidget {
  const CareEvidence({Key? key, required this.plotId}) : super(key: key);

  final String plotId;

  @override
  State<CareEvidence> createState() => _CareEvidenceState();
}

class _CareEvidenceState extends State<CareEvidence> {
  late final CareBloc _bloc = CareBloc(ApiService())..add(LoadCaresEvent(widget.plotId));
  late final AppLocalizations _localization = AppLocalizations.of(context)!;
  bool _isAddingNewOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CareBloc, CareState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is NewCareSuccessfullyAddedState) {
          displayToast(
            message: _localization.newCareSuccessAdd,
          );
        }

        if (state is NewCareErrorState) {
          displayToast(
            message: _localization.newCareError,
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
        if (state is LoadingCaresState) {
          return FructifyVerticalLoader(
            title: _localization.care,
          );
        }

        if (state is CaresLoadedState) {
          return Column(
            children: [
              _headerRow(),
              const SizedBox(height: 10),
              if (_isAddingNewOpen)
                NewCareForm(
                  closeForm: () => setState(() => _isAddingNewOpen = false),
                  plotId: widget.plotId,
                  bloc: _bloc,
                ),
              ...state.cares
                  .map((e) => CareTile(
                        care: e,
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
        Text(_localization.care, style: FructifyStyles.textStyle.headerStyle3),
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
