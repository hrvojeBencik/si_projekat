import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/mock_data.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/models/plot.dart';
import 'package:si_app/src/pages/plots/care/care_evidence.dart';
import 'package:si_app/src/pages/plots/tillage/tillage_evidence.dart';
import 'package:si_app/src/pages/plots/watering/watering_evidence.dart';
import 'package:si_app/src/widgets/fructify_footer.dart';

class PlotPage extends StatefulWidget {
  // const PlotPage({Key? key, required this.plot}) : super(key: key);
  PlotPage({Key? key}) : super(key: key);

  // final Plot plot;
  final Plot plot = MockData.plot;

  @override
  State<PlotPage> createState() => _PlotPageState();
}

class _PlotPageState extends State<PlotPage> {
  late Size size;
  final Set<Polygon> _polygons = HashSet<Polygon>();
  late final CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _polygons.add(
      Polygon(
        polygonId: PolygonId(widget.plot.name),
        points: widget.plot.coordinates,
        fillColor: FructifyColors.whiteGreen.withOpacity(0.2),
        strokeColor: FructifyColors.lightGreen,
        strokeWidth: 2,
        geodesic: true,
      ),
    );
    _initialCameraPosition = CameraPosition(target: widget.plot.coordinates.first, zoom: 20);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width > 1000 ? 200 : 10),
          child: Column(
            children: [
              _header(),
              // _map(),
              _customDivider(),
              TillageEvidence(
                plotId: widget.plot.id!,
              ),
              _customDivider(),
              WateringEvidence(
                plotId: widget.plot.id!,
              ),
              _customDivider(),
              CareEvidence(
                plotId: widget.plot.id!,
              ),
              const SizedBox(height: 50),
              FructifyFooter(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        color: FructifyColors.lightGreen,
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        widget.plot.name,
        style: FructifyStyles.textStyle.headerStyle2,
      ),
    );
  }

  Container _map() {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          polygons: _polygons,
          mapType: MapType.satellite,
        ),
      ),
    );
  }
}
