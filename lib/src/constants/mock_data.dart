import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:si_app/src/models/plot.dart';

class MockData {
  static final Plot plot = Plot(
    id: '62837b43589c77d7c9e511ef',
    name: 'Moj vocnjak',
    coordinates: [
      const LatLng(46.03669411201246, 19.43100153226555),
      const LatLng(46.036506051419835, 19.431256342121966),
      const LatLng(46.03592138370735, 19.430454361626513),
      const LatLng(46.03610386028166, 19.43017272967995),
    ],
    firebaseUserId: 'RHXRL2rTX6O5W7BOOEmyYmPCfuo1',
  );
}
