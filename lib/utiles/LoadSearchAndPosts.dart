import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:remi/cdt/cdt.dart';
import 'package:remi/config.dart';

/// If you want use firebase_database
/// Edit your build.gradle
/// minSdkVersion = 19
/// Answer for error:
///   https://github.com/firebase/flutterfire/issues/9049#issuecomment-1177501363
///
/// SDK Platform release notes
/// https://developer.android.com/studio/releases/platforms

class ServWidget {
  String address;
  String home_image_path;
  String title;
  String stars_count;

  ServWidget(String this.title, String this.home_image_path, String this.address, String this.stars_count);
}


/// "restaurant": 1,
///   "coffee": 2,
///   "bar": 3,
///   "pizzeria": 4,
///   "pub": 5
Future<List<dynamic>> addServices({ double? c_width,  double? c_height, List<bool>? filter_adds, List<bool>? loaded }) async {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  debugLog(CDTColors.Red, "addServices() is running...");

  List<Widget> All = [];
  List<ServWidget> swt = [];
  Set<Marker> all_markers = new Set();

  List<bool> wbb = [false, false, false, false, false];

  for (int i = 0; i < filter_adds!.length; i++) {
    debugLog(CDTColors.Magenta, i.toString());
    if (loaded![i] == true && filter_adds[i] == true) {
      wbb[i] = false;
    }
    else if (loaded[i] == false && filter_adds[i] == true) {
      wbb[i] = true;
    }
  }

  debugLog(CDTColors.Green, "filter_ads: $filter_adds\nloaded: $loaded");
  debugLog(CDTColors.Green, wbb.toString());

  debugLog(CDTColors.Red, "1");
  for (int i = 0; i < filter_adds.length; i++) {
    debugLog(CDTColors.Red, "3");
    List<dynamic> tmp_swt = await addForWidgetPage(ref, i, wbb);

    swt += tmp_swt[0];
    all_markers.addAll(tmp_swt[1]);

    if (swt.length != 0) {
      // assembly to List<Widget>
      for (int i = 0; i < swt.length; i++) {
        String tmp_sc = swt[i].stars_count.replaceAll(",", ".");
        double sc_d = double.parse(tmp_sc);

        int stars_count = sc_d >= 4.5 ? 5 : 4;

        String stars = "";
        for (int j = 0; j < stars_count; j++) {
          stars += "⭐";
        }

        // debugLog(CDTColors.Blue, sc_d.toString());
        Widget tmpW = Padding(
            padding: EdgeInsets.all(5),
            child: InkWell(
              onTap: () {print(i);},
              child: Container(
                width: c_width,
                height: c_height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(28, 0, 0, 0),
                        spreadRadius: 0,
                        blurRadius: 82,
                        offset: Offset(0, 4)),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top: 7,
                        left: 7,
                        width: c_width! / 1.15,
                        height: c_height! - 14,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(swt[i].home_image_path),
                              )
                          ),
                        )
                    ),
                    Positioned(
                      top: 7,
                      left: 14 + (c_width / 1.15),
                      width: c_width / 1,
                      child: Text(
                        swt[i].title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Positioned(
                        top: 40 + 7 + 5,
                        left: 14 + (c_width / 1.15),
                        width: c_width / 1.1,
                        child: Text(swt[i].address)
                    ),
                    Positioned(
                        left: 14 + (c_width / 1.15),
                        bottom: 10,
                        child: Text(
                          stars,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto'
                          ),
                        )
                    )
                  ],
                ),
              ),
            )
        );

        All.add(tmpW);
      }
      swt = [];
    }

  }

  List<bool> gnll = generateNewLoadedList(wbb, loaded!);
  
  List<dynamic> result = [All, all_markers, gnll];

  debugLog(CDTColors.Blue, "0x0");
  debugLog(CDTColors.Blue, result.toString());

  return result;
}


List<bool> generateNewLoadedList(List<bool> wbb, List<bool> loaded) {
  List<bool> result = [];

  for (int i = 0; i < wbb.length; i++) {
    if (wbb[i] == true && loaded[i] == true) {
      result[i] = true;
    }
    else if (wbb[i] == true && loaded[i] == false) {
      result[i] = true;
    }
    else if (wbb[i] == false && loaded[i] == false) {
      result[i] = false;
    }
    else if (wbb[i] == false && loaded[i] == true) {
      result[i] = true;
    }
  }

  return result;
}


Future<List<dynamic>> addForWidgetPage(DatabaseReference reference, int index, List<bool> selected_filters) async {
  List<ServWidget> swt = [];
  Set <Marker> markers = new Set();



  if (selected_filters[index] == true) {
    String type = AppConfig.DEFAULT_SERVICES_TYPES[index];

    for (int i = 0; i <= 30; i++) {
      DataSnapshot tmp = await reference.child(
          '${AppConfig.DEFAULT_SERV}/country/${AppConfig
              .DEFAULT_COUNTRY}/city/${AppConfig
              .DEFAULT_CITY}/type/$type/${AppConfig.DEFAULT_S_NUM['$type']
              .toString()}$i').get();

      if (tmp.value.toString() == "null") {
        continue;
      } else {
        Map<String, dynamic> data = jsonDecode(jsonEncode(tmp.value)) as Map<
            String,
            dynamic>;

        try {

          // GBSearchData Class Provided By geocoder_buddy
          List<GBSearchData> gsd = await GeocoderBuddy.query(data['address'].toString());

          // GBData Class Provided By geocoder_buddy
          GBData gbd = await GeocoderBuddy.searchToGBData(gsd.first);

          double position_lat = double.parse(gbd.lat);
          double position_lon = double.parse(gbd.lon);

          await markers.add(Marker(
            markerId: MarkerId(gbd.id.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(position_lat, position_lon),
            infoWindow: InfoWindow(
              title: data['title'].toString(),
              snippet: "Type: $type, Address: ${data['address'].toString()}",
            ),
          )
          );
        } catch (e) {
          debugLog(CDTColors.Green, e.toString());
        }

        swt.add(ServWidget(
            data['title'].toString(), data['home_image'].toString(),
            data['address'].toString(), data['stars'].toString()));

      }
    }
  }

  debugLog(CDTColors.Green, "0xALAPAFWP0");

  return [swt, markers];
}

