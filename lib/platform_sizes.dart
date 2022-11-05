import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';

class PlatformSizes {
  final String devicePlatform;
  final BuildContext _context;

  PlatformSizes(String this.devicePlatform, BuildContext this._context);

  /// Init Screen size [_SCREEN_WIDTH] and [_SCREEN_HEIGHT]
  void initScreenSize() {
    this._SCREEN_WIDTH = MediaQuery.of(this._context).size.width;
    this._SCREEN_HEIGHT = MediaQuery.of(this._context).size.height;
  }

  double _SCREEN_WIDTH  = 0;
  double _SCREEN_HEIGHT = 0;

  // CONTENTIN [On page LOG_IN and SIGN_UP]
  final double _DEFAULT_HEIGHT_CONTENTIN = 450;

  /// sizeType
  /// true - height
  /// false - width
  double getContentInSize(bool sizeType) {

    if (sizeType) {
      if (devicePlatform == Platform.isIOS) {
        return 561;
      } else {
        return _DEFAULT_HEIGHT_CONTENTIN;
      }
    } else {
      return _SCREEN_WIDTH;
    }
  }


  double ScreenWidth() {
    return this._SCREEN_WIDTH;
  }

  double ScreenHeight() {
    return this._SCREEN_HEIGHT;
  }

}

class windowSize {
  final MediaQueryData _WINDOW = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  double getWidthWithoutContext() {
    return this._WINDOW.size.width;
  }
  double getHeightWithoutContext() {
    return this._WINDOW.size.height;
  }
}