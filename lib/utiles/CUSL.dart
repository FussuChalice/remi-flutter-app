import 'package:firebase_database/firebase_database.dart';
import 'package:remi/cdt/cdt.dart';
import 'package:remi/config.dart';

class snapshotValueInterface {
  String address;
  String home_img_url;
  List<String> imgs_url;
  String stars;
  String title;

  snapshotValueInterface(this.title, this.address, this.home_img_url, this.stars, this.imgs_url);
}

/// CUSL: Card Update Search Load
/// This class wrote for me, for my tasks.
class CUSL {
  String DB_NAME;
  int UpdateCardCount = 5;

  CUSL(this.DB_NAME);

  Future<List<dynamic>> LoadCardsByFilters({required List<bool> filter_selections,  required List<int> before_loaded, required int beforeLoadedCount, String? Scountry, String? Scity, bool? ReturnMarkers}) async {

    String country = Scountry == null ? AppConfig.DEFAULT_COUNTRY : Scountry;
    String city = Scountry == null ? AppConfig.DEFAULT_CITY : Scountry;

    bool returnMarkers = ReturnMarkers == null ? false : ReturnMarkers;

    DatabaseReference ref = FirebaseDatabase.instance.ref();

    List<dynamic> tempLoaded = [];

    for (int i = 0; i < filter_selections.length; i++) {

      if (filter_selections[i]) {
        // get filter_selected type
        String fs_type = AppConfig.DEFAULT_SERVICES_TYPES[i];

        // get first_num for correct ID of item
        int? serv_first_num = AppConfig.DEFAULT_S_NUM[fs_type];

        for (int j = 0; j <= this.UpdateCardCount; j++) {
          var data = await getValueFromSnapshot(reference: ref, path: '${this.DB_NAME}/country/$country/city/$city/type/$fs_type/${serv_first_num}2');
          debugLog(CDTColors.Green, data.toString());
        }


      } else {
        continue;
      }
    }

    return [0x0000, 0x1000];
  }

  Future<List<dynamic>> cycleForOne(Future<dynamic> nextFunc) async {
    return [0x0, 0x2000];
  }

  Future<dynamic> getValueFromSnapshot({required DatabaseReference reference, required String path}) async {

    final snapshotData = await reference.child(path).get();
    if (snapshotData.exists) {
      return snapshotData.value;
    } else {
      return null;
    }
  }

}
