import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:si_app/src/bloc/plots/bloc/plots_bloc.dart';
import 'package:si_app/src/models/plot.dart';
import 'package:si_app/src/pages/plots/new_plot_form.dart';
import 'package:si_app/src/pages/plots/plot_tile.dart';
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
    return BlocBuilder<PlotsBloc, PlotsState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is PlotsLoadingState) return const FructifyLoader();

        if (state is PlotsLoadedState) return _showPlots(state.plots);
        // if (state is PlotsLoadedState)
        //   return NewPlotForm(
        //     cancelForm: () => _bloc.add(CancelAddingNewPlotEvent()),
        //     addPlot: (plot) => _bloc.add(AddNewPlotEvent(plot)),
        //   );

        if (state is AddingNewPlotState)
          return NewPlotForm(
            cancelForm: () => _bloc.add(CancelAddingNewPlotEvent()),
            addPlot: (plot) => _bloc.add(AddNewPlotEvent(plot)),
          );

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
            Text(_localization.noAddedPlots),
            TextButton(
              onPressed: () => _bloc.add(OpenNewPlotFormEvent()),
              child: Text(_localization.addPlot),
            ),
          ],
        ),
      );
    }

    return Column(
      children: plots.map((e) => PlotTile(plot: e)).toList(),
    );
  }
}
