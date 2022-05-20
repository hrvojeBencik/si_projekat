import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/models/plot.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';
import 'package:si_app/src/widgets/fructify_button.dart';
import 'package:si_app/src/widgets/fructify_loader.dart';

enum MapStates {
  loading,
  successfullyLoaded,
  serviceError,
  permissionError,
}

class NewPlotForm extends StatefulWidget {
  const NewPlotForm({Key? key, required this.cancelForm, required this.addPlot}) : super(key: key);

  final Function cancelForm;
  final Function(Plot plot) addPlot;

  @override
  State<NewPlotForm> createState() => _NewPlotFormState();
}

class _NewPlotFormState extends State<NewPlotForm> {
  late Size size;
  Location location = Location();
  late final _localization = AppLocalizations.of(context)!;
  bool _serviceEnabled = false;
  late PermissionStatus _permissionStatus;
  LocationData? _locationData;
  CameraPosition _initialCameraPosition = const CameraPosition(target: LatLng(45.521563, -122.677433), zoom: 20);
  MapStates _mapState = MapStates.loading;
  final Set<Marker> _markers = HashSet<Marker>();
  final Set<Polygon> _polygons = HashSet<Polygon>();
  final List<LatLng> _points = [];
  final TextEditingController _plotNameController = TextEditingController();
  String _plotName = '';
  int _markerIdCounter = 1;

  @override
  void initState() {
    super.initState();

    _plotNameController.addListener(() {
      setState(() {
        _plotName = _plotNameController.text;
      });
    });

    _polygons.add(
      Polygon(
        polygonId: PolygonId('${_markers.length}'),
        points: _points,
        fillColor: FructifyColors.whiteGreen.withOpacity(0.2),
        strokeColor: FructifyColors.lightGreen,
        strokeWidth: 2,
        geodesic: true,
      ),
    );
    _getCurrentLocation().then((value) {
      if (_locationData != null) {
        _initialCameraPosition = CameraPosition(
          target: LatLng(
            _locationData!.latitude!,
            _locationData!.longitude!,
          ),
          zoom: 18,
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    _plotNameController.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
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
            children: [
              _heading(),
              _map(),
              _displayPointCoordinates(),
              _plotNameField(),
              _buttonRow(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Row _buttonRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _submitButton(),
        const SizedBox(width: 20),
        _cancelButton(),
      ],
    );
  }

  Padding _heading() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_localization.addPlot, style: FructifyStyles.textStyle.headerStyle2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _localization.addPlotPinsTutorialText,
                        style: TextStyle(fontSize: 18, color: FructifyColors.darkGreen.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => widget.cancelForm(),
            icon: const Icon(
              Icons.close,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cancelButton() {
    return FructifyButton(
      text: _localization.cancel,
      onClick: () => widget.cancelForm(),
      bgColor: Colors.red,
      hoverColor: Colors.red[300],
      detailsColor: Colors.white,
      width: 200,
    );
  }

  Widget _submitButton() {
    return FructifyButton(
      text: _localization.submit,
      onClick: _points.length < 3 || _plotName.isEmpty
          ? null
          : () {
              final Plot _plot = Plot(
                firebaseUserId: context.read<UserRepository>().getFirebaseId(),
                name: _plotNameController.text,
                coordinates: _points,
              );

              widget.addPlot(_plot);
            },
      width: 200,
    );
  }

  Widget _displayPointCoordinates() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        children: _markers.map((e) => _markerTile(e)).toList(),
        spacing: 10,
        runSpacing: 10,
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          _mapState = MapStates.serviceError;
        });
        return;
      }
    }

    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        setState(() {
          _mapState = MapStates.permissionError;
        });
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      _mapState = MapStates.successfullyLoaded;
    });
  }

  Container _map() {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: _mapState == MapStates.loading
          ? const FructifyLoader()
          : ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: GoogleMap(
                initialCameraPosition: _initialCameraPosition,
                markers: _markers,
                polygons: _polygons,
                mapType: MapType.satellite,
                onTap: (tapPosition) {
                  setState(
                    () {
                      _markers.add(Marker(
                        markerId: MarkerId('$_markerIdCounter'),
                        position: tapPosition,
                      ));
                      _markerIdCounter++;

                      _points.add(tapPosition);
                    },
                  );
                },
              ),
            ),
    );
  }

  Widget _markerTile(Marker marker) {
    return Container(
      decoration: BoxDecoration(
        color: FructifyColors.whiteGreen,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${marker.markerId.value}. ${marker.position.latitude}, ${marker.position.longitude}',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _markers.remove(marker);
                if (_polygons.isNotEmpty) {
                  _points.remove(marker.position);
                }
              });
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _plotNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 20,
      ),
      child: TextField(
        controller: _plotNameController,
        cursorColor: FructifyColors.lightGreen,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: FructifyColors.whiteGreen),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: FructifyColors.lightGreen),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: _localization.addPlotName,
        ),
      ),
    );
  }
}
