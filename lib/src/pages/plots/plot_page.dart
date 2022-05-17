import 'package:flutter/material.dart';
import 'package:si_app/src/models/plot.dart';

class PlotPage extends StatefulWidget {
  const PlotPage({Key? key, required this.plot}) : super(key: key);

  final Plot plot;

  @override
  State<PlotPage> createState() => _PlotPageState();
}

class _PlotPageState extends State<PlotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(widget.plot.name),
      ),
    );
  }
}
