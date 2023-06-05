import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';

class HomeResultsLoader {
  Future<http.Response> _fetchSettingsByID(int prevId) {
    int currentId = prevId + 1;
    return http.get(
        Uri.parse(
            "${AppConfig.SERVER_API_PROTOCOL}://${AppConfig.SERVER_API_BASE}"
                "/data/settings/${currentId.toString()}"
        )
    );
  }

  


}