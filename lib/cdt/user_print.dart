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
