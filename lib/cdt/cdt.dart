/// # CDT lib
export './font_settings.dart';
export './user_print.dart';
export './work_with_files.dart';
export './authorization.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

/// For USE this "library"
/// Add dependencies to pubsec.yaml
///
///   firebase_auth:
///   firebase_core:
///   firebase_storage:
///   google_sign_in:
///   connectivity_plus:
///   the_apple_sign_in:
///   path_provider:
///   firebase_auth_oauth:
///
/// 

Future<bool> checkEthernetConnectivity() async {
  ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult != ConnectivityResult.wifi && connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.bluetooth) {
    return false;

  } else {

    return true;
  }
}

