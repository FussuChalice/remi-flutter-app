import 'dart:convert';

import 'package:remi/config.dart';

import './models/Service.dart';
import 'package:http/http.dart' as http;

class RemiNetworkLoader {
  Future<Service> fetchService(String id) async {
    final response = await http.get(
      Uri.parse('${AppConfig.SERVER_API_PROTOCOL}${AppConfig.SERVER_API_PROTOCOL}data/settings/$id')
    );

    if (response.statusCode == 200) {
      return Service.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load service');
    }
  }
}