import 'package:flutter/material.dart';
import 'package:remi/cdt/font_settings.dart';
import 'package:intl/intl.dart';

/// cdt.user_print.debugLog
///
/// Input:
///   - Color <= You can get from [FColors]
///   - Content <= [String]
void debugLog(String borderColor, String content) {
  String border = '═══════════════════════════════════════════';

  // Get current date and time for log
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd H:m:s');
  final String formatted = formatter.format(now);

  print('${borderColor}${border}${CDTColors.Reset}');
  print('[ $formatted ] ${content}');
  print('${borderColor}${border}${CDTColors.Reset}');
}

/// Display Snackbar [Text] to User on Screen.
/// Recommend use on debug app version.
void displayOnScreen(Text content, BuildContext context) {

  // More information about snackbar: https://docs.flutter.dev/cookbook/design/snackbars
  final snackBar = SnackBar(content: content);

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}