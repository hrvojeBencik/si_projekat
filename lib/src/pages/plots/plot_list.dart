import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/plots/bloc/plots_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/models/plot.dart';
import 'package:si_app/src/pages/plots/new_plot_form.dart';
import 'package:si_app/src/pages/plots/plot_tile.dart';
import 'package:si_app/src/utils/toast.dart';
import 'package:si_app/src/widgets/fructify_button.dart';
import 'package:si_app/src/widgets/fructify_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlotList extends StatefulWidget {
  const PlotList({Key? key}) : super(key: key);

  @override
  State<PlotList> createState() => _PlotListState();
}

class _PlotListState extends State<PlotList> {
  late final PlotsBloc _bloc = context.read<PlotsBloc>()..add(FetchPlotsEvent());
  late final _localization = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlotsBloc, PlotsState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SuccessfullyAddedPlotState) {
          displayToast(message: _localization.successfullyAddedPlot);
        }

        if (state is SuccessfulDelete) {
          displayToast(message: _localization.successfulDelete, color: FructifyColors.red);
        }
      },
      builder: (context, state) {
        if (state is PlotsLoadingState) return const FructifyLoader();

        if (state is PlotsLoadedState) return _showPlots(state.plots);

        if (state is AddingNewPlotState) {
          return NewPlotForm(
            cancelForm: () => _bloc.add(CancelAddingNewPlotEvent()),
            addPlot: (plot) => _bloc.add(AddNewPlotEvent(plot)),
          );
        }

        return const Text('Plots error');
      },
    );
  }

  Widget _showPlots(List<Plot> plots) {
    if (plots.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_off_outlined,
              color: FructifyColors.lightGreen,
              size: 50,
            ),
            Text(_localization.noAddedPlots, style: FructifyStyles.textStyle.headerStyle3),
            const SizedBox(height: 20),
            _openNewPlotFormButton(),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 2000
              ? 600
              : MediaQuery.of(context).size.width > 1650
                  ? 400
                  : MediaQuery.of(context).size.width > 1000
                      ? 200
                      : 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Text(
                _localization.savedPlots,
                style: FructifyStyles.textStyle.headerStyle2,
              ),
            ),
            ...plots.map((e) => PlotTile(plot: e)).toList(),
            Align(
              alignment: Alignment.center,
              child: _openNewPlotFormButton(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _openNewPlotFormButton() {
    return FructifyButton(
      onClick: () => _bloc.add(OpenNewPlotFormEvent()),
      text: _localization.addPlot,
    );
  }
}
