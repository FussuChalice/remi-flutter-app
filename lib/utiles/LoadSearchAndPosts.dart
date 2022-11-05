import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:remi/cdt/cdt.dart';

/// If you want use firebase_database
/// Edit your build.gradle
/// minSdkVersion = 19
/// Answer for error:
///   https://github.com/firebase/flutterfire/issues/9049#issuecomment-1177501363
///
/// SDK Platform release notes
/// https://developer.android.com/studio/releases/platforms

/// Set default args
final __DEFAULT_COUNTRY_ = "UnitedKingdom";
final __DEFAULT_CITY_ = "London";
final __DEFAULT_SERV_ = "hdb";

final Map<String, int> __DEFAULT_S_NUM_ = {
  "restaurant": 1,
  "coffee": 2,
  "bar": 3,
  "pizzeria": 4,
  "pub": 5
};

class ServWidget {
  String address;
  String home_image_path;
  String title;
  String stars_count;

  ServWidget(String this.title, String this.home_image_path, String this.address, String this.stars_count);
}

// class ReturnedParam {
//   List<Widget> widg;
//   List<bool> loaded;
//
//   ReturnedParam(List<Widget> r)
// }

// Future<List<Widget>>


/// "restaurant": 1,
///   "coffee": 2,
///   "bar": 3,
///   "pizzeria": 4,
///   "pub": 5
Future<List<Widget>> addServices(double c_width, double c_height, List<bool> filter_adds) async {
  final ref = FirebaseDatabase.instance.ref();

  List<Widget> All = [];
  List<ServWidget> swt = [];

  for (int c = 0; c < filter_adds.length; c++) {
    String type = "";
    if (c == 0 && filter_adds[c] == true) {
      type = "restaurant";

      for (int i = 0; i <= 30; i++) {
        DataSnapshot tmp = await ref.child('$__DEFAULT_SERV_/country/$__DEFAULT_COUNTRY_/city/$__DEFAULT_CITY_/type/$type/${__DEFAULT_S_NUM_['$type'].toString()}$i').get();

        if (tmp.value.toString() == "null") {
          continue;
        } else {

          Map<String, dynamic> data = jsonDecode(jsonEncode(tmp.value))  as Map<String, dynamic>;

          swt.add(ServWidget(data['title'].toString(), data['home_image'].toString(), data['address'].toString(), data['stars'].toString()));

          // debugLog(CDTColors.Yellow, data.toString());
        }
      }
    }

    if (c == 1 && filter_adds[c] == true) {
      type = "coffee";

      for (int i = 0; i <= 30; i++) {
        DataSnapshot tmp = await ref.child('$__DEFAULT_SERV_/country/$__DEFAULT_COUNTRY_/city/$__DEFAULT_CITY_/type/$type/${__DEFAULT_S_NUM_['$type'].toString()}$i').get();

        if (tmp.value.toString() == "null") {
          continue;
        } else {

          Map<String, dynamic> data = jsonDecode(jsonEncode(tmp.value))  as Map<String, dynamic>;

          swt.add(ServWidget(data['title'].toString(), data['home_image'].toString(), data['address'].toString(), data['stars'].toString()));

          debugLog(CDTColors.Yellow, data.toString());
        }
      }
    }

    if (c == 2 && filter_adds[c] == true) {
      type = "bar";

      for (int i = 0; i <= 30; i++) {
        DataSnapshot tmp = await ref.child('$__DEFAULT_SERV_/country/$__DEFAULT_COUNTRY_/city/$__DEFAULT_CITY_/type/$type/${__DEFAULT_S_NUM_['$type'].toString()}$i').get();

        if (tmp.value.toString() == "null") {
          continue;
        } else {

          Map<String, dynamic> data = jsonDecode(jsonEncode(tmp.value))  as Map<String, dynamic>;

          swt.add(ServWidget(data['title'].toString(), data['home_image'].toString(), data['address'].toString(), data['stars'].toString()));

          debugLog(CDTColors.Yellow, data.toString());
        }
      }
    }

    if (c == 3 && filter_adds[c] == true) {
      type = "pizzeria";

      for (int i = 0; i <= 30; i++) {
        DataSnapshot tmp = await ref.child('$__DEFAULT_SERV_/country/$__DEFAULT_COUNTRY_/city/$__DEFAULT_CITY_/type/$type/${__DEFAULT_S_NUM_['$type'].toString()}$i').get();

        if (tmp.value.toString() == "null") {
          continue;
        } else {

          Map<String, dynamic> data = jsonDecode(jsonEncode(tmp.value))  as Map<String, dynamic>;

          swt.add(ServWidget(data['title'].toString(), data['home_image'].toString(), data['address'].toString(), data['stars'].toString()));

          debugLog(CDTColors.Yellow, data.toString());
        }
      }
    }

    if (c == 4 && filter_adds[c] == true) {
      type = "pub";

      for (int i = 0; i <= 30; i++) {
        DataSnapshot tmp = await ref.child('$__DEFAULT_SERV_/country/$__DEFAULT_COUNTRY_/city/$__DEFAULT_CITY_/type/$type/${__DEFAULT_S_NUM_['$type'].toString()}$i').get();

        if (tmp.value.toString() == "null") {
          continue;
        } else {

          Map<String, dynamic> data = jsonDecode(jsonEncode(tmp.value))  as Map<String, dynamic>;

          swt.add(ServWidget(data['title'].toString(), data['home_image'].toString(), data['address'].toString(), data['stars'].toString()));

          debugLog(CDTColors.Yellow, data.toString());
        }
      }
    }

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
                        width: c_width / 1.15,
                        height: c_height - 14,
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

  return All;
}
