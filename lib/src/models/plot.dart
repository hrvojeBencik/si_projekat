import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Plot> getAllPlotsFromJson(Iterable data) {
  return List<Plot>.from(data.map((model) => Plot.fromJson(model)));
}

class Plot {
  final String? id;
  final String name;
  final List<LatLng> coordinates;
  final String firebaseUserId;

  Plot({
    this.id,
    required this.name,
    required this.coordinates,
    required this.firebaseUserId,
  });

  factory Plot.fromJson(Map<String, dynamic> data) {
    return Plot(
      id: data['_id'],
      name: data['title'],
      coordinates: _getCoordinates(data['coordinates']),
      firebaseUserId: data['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": name,
      "coordinates": json.encode(coordinates),
      "userId": firebaseUserId,
    };
  }

  static List<LatLng> _getCoordinates(String data) {
    List<LatLng> list = [];
    List decodedData = json.decode(data);
    for (var element in decodedData) {
      list.add(LatLng(
        element[0],
        element[1],
      ));
    }

    return list;
  }
}
