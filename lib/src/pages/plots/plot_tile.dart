import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/models/plot.dart';
import 'package:si_app/src/pages/plots/plot_page.dart';

class PlotTile extends StatelessWidget {
  const PlotTile({Key? key, required this.plot}) : super(key: key);
  final Plot plot;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double latitude = 0.0;
    double longitude = 0.0;
    for (var item in plot.coordinates) {
      latitude += item.latitude;
      longitude += item.longitude;
    }

    latitude /= plot.coordinates.length;
    longitude /= plot.coordinates.length;

    final CameraPosition _initialCameraPosition = CameraPosition(target: LatLng(latitude, longitude), zoom: 17);

    return Material(
      color: Colors.white,
      child: InkWell(
        overlayColor: MaterialStateProperty.all<Color>(FructifyColors.whiteGreen),
        onTap: () {
          // Go to plot screen
          Navigator.push(context, MaterialPageRoute(builder: (context) => PlotPage(plot: plot)));
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: size.width <= 1000 ? 180 : 300,
                height: size.width <= 1000 ? 90 : 150,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GoogleMap(
                    mapType: MapType.satellite,
                    initialCameraPosition: _initialCameraPosition,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    mapToolbarEnabled: false,
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    markers: {
                      Marker(
                        markerId: MarkerId(plot.name),
                        position: LatLng(latitude, longitude),
                      ),
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(child: Text(plot.name, style: FructifyStyles.textStyle.headerStyle2)),
            ],
          ),
        ),
      ),
    );
  }
}
