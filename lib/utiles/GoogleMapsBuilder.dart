/// file: GoogleMapsBuilder.dart
/// Build markers for Google Maps
/// Create ways from user geoposition to service

import 'package:firebase_database/firebase_database.dart';

import "../config.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

// Future<Set<Marker>> loadMarkersByAddress(List<bool> filter_adds) async {
//   final ref = FirebaseDatabase.instance.ref();
//
//
//   /// I know that copy
//   for (int i = 0; i < filter_adds.length; i++) {
//     String type = "";
//
//     if (i == 0 && filter_adds[i] == true) {
//
//     }
//
//   }
// }