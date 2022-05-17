import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/models/plot.dart';

class PlotTile extends StatelessWidget {
  const PlotTile({Key? key, required this.plot}) : super(key: key);
  final Plot plot;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CameraPosition _initialCameraPosition = CameraPosition(target: plot.coordinates.first, zoom: 30);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width <= 1000 ? 10 : 200, vertical: 10),
      child: Material(
        color: Colors.white,
        child: InkWell(
          overlayColor: MaterialStateProperty.all<Color>(FructifyColors.whiteGreen),
          onTap: () {
            // Go to plot screen
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
                          position: plot.coordinates.first,
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
      ),
    );
  }
}
