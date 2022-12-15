import 'package:firebase_database/firebase_database.dart';

Future<dynamic> chipGrabber({
  required Function(DatabaseReference) function,
  required List<bool> add_chip,
  required Map<String, int> selected_nums,
  required DatabaseReference reference,

}) async {

  for (int cgi = 0; cgi < add_chip.length; cgi++) {
    await function(reference);
  }

}

Future<dynamic> checkChipSimilarity({required int index, required List<bool> added_chips, List<String>? types, required Function(String, ) function,}) async {
  // if you don't use types set to list null

  if (added_chips[index] == true) {
    /// in your func must be area for type, ever you not use this
    String type = types![index].toString();

    await function(type);
  }

}

