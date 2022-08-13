import 'package:flutter/material.dart';
import 'package:remi/cdt/font_settings.dart';

/// cdt.user_print.debugLog
///
/// Input:
///   - Color <= You can get from [FColors]
///   - Content <= [String]
void debugLog(String borderColor, String content) {
  String border = '═══════════════════════════════════════════';

  print('${borderColor}${border}${CDTColors.Reset}');
  print('${content}');
  print('${borderColor}${border}${CDTColors.Reset}');
}

/// Display Snackbar [Text] to User on Screen.
/// Recommend use on debug app version.
void displayOnScreen(Text content, BuildContext context) {

  // More information about snackbar: https://docs.flutter.dev/cookbook/design/snackbars
  final snackBar = SnackBar(content: content);

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}