import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:si_app/src/bloc/plots/bloc/plots_bloc.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/models/plot.dart';
import 'package:si_app/src/models/weather.dart';
import 'package:si_app/src/pages/plots/care/care_evidence.dart';
import 'package:si_app/src/pages/plots/supplementation/supplementation_evidence.dart';
import 'package:si_app/src/pages/plots/tillage/tillage_evidence.dart';
import 'package:si_app/src/pages/plots/watering/watering_evidence.dart';
import 'package:si_app/src/pages/plots/weather_widget.dart';
import 'package:si_app/src/pages/plots/yield/yield_evidence.dart';
import 'package:si_app/src/services/weather_service.dart';
import 'package:si_app/src/widgets/custom_divider.dart';
import 'package:si_app/src/widgets/fructify_footer.dart';
import 'package:si_app/src/widgets/fructify_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlotPage extends StatefulWidget {
  const PlotPage({Key? key, required this.plot}) : super(key: key);
  // PlotPage({Key? key}) : super(key: key);

  final Plot plot;
  // final Plot plot = MockData.plot;

  @override
  State<PlotPage> createState() => _PlotPageState();
}

class _PlotPageState extends State<PlotPage> {
  final WeatherService _weatherService = WeatherService();
  late Size size;
  final Set<Polygon> _polygons = HashSet<Polygon>();
  late final CameraPosition _initialCameraPosition;
  late final LatLng _middleOfPlot;
  late Future<Weather?> getCurrentWeather = _weatherService.getCurrentWeatherByCoordinates(_middleOfPlot);

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

    double latitude = 0.0;
    double longitude = 0.0;
    for (var item in widget.plot.coordinates) {
      latitude += item.latitude;
      longitude += item.longitude;
    }

    latitude /= widget.plot.coordinates.length;
    longitude /= widget.plot.coordinates.length;
    _middleOfPlot = LatLng(latitude, longitude);
    _initialCameraPosition = CameraPosition(target: LatLng(latitude, longitude), zoom: 18);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width > 2000
                  ? 600
                  : size.width > 1650
                      ? 400
                      : size.width > 1000
                          ? 200
                          : 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _map(),
                    ),
                    if (size.width > 1400) Expanded(flex: 1, child: _weather()),
                  ],
                ),
                if (size.width < 1400)
                  Align(
                    alignment: Alignment.center,
                    child: _weather(),
                  ),
                const CustomDivider(),
                TillageEvidence(
                  plotId: widget.plot.id!,
                ),
                const CustomDivider(),
                WateringEvidence(
                  plotId: widget.plot.id!,
                ),
                const CustomDivider(),
                CareEvidence(
                  plotId: widget.plot.id!,
                ),
                const CustomDivider(),
                SupplementationEvidence(
                  plotId: widget.plot.id!,
                ),
                const CustomDivider(),
                YieldEvidence(plotId: widget.plot.id!),
                const SizedBox(height: 50),
                FructifyFooter(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.plot.name,
            style: FructifyStyles.textStyle.headerStyle2,
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              context.read<PlotsBloc>().add(RemovePlotEvent(widget.plot));
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              size: 40,
              color: FructifyColors.red,
            ),
          ),
          const Spacer(),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              size: 40,
            ),
          ),
        ],
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

  Widget _weather() {
    return FutureBuilder<Weather?>(
      future: getCurrentWeather,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const FructifyLoader();
        }

        if (snapshot.data == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.weatherLoadError,
                style: FructifyStyles.textStyle.errorMessageStyle,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return WeatherWidget(
          weather: snapshot.data!,
          reloadWeather: () {
            getCurrentWeather = _weatherService.getCurrentWeatherByCoordinates(_middleOfPlot);
          },
        );
      },
    );
  }
}
