/// ## CDTColors
/// It's small class for colorize your print() command in Dart language.
/// Base colors for console
class CDTColors {
  CDTColors._();

  // Colors for debug console
  static const String Black = '\x1B[30m';
  static const String Red = '\x1B[31m';
  static const String Green = '\x1B[32m';
  static const String Yellow = '\x1B[33m';
  static const String Blue = '\x1B[34m';
  static const String Magenta = '\x1B[35m';
  static const String Cyan = '\x1B[36m';
  static const String White = '\x1B[37m';
  static const String Reset = '\x1B[0m';
}

/// # CDTStyle
/// Styles for font
class CDTStyle {
  CDTStyle._();

  // Font Styles
  static const String Bold = '\x1B[1m';
  static const String Italic = '\x1B[3m';
  static const String BoldItalic = '\x1B[1;3m';
  static const String Close = '\x1B[0m';
}
