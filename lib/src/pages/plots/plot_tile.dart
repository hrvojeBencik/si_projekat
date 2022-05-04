import 'package:flutter/material.dart';
import 'package:si_app/src/models/plot.dart';

class PlotTile extends StatelessWidget {
  const PlotTile({Key? key, required this.plot}) : super(key: key);
  final Plot plot;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(plot.name),
    );
  }
}
