import 'dart:convert';
import './models/Service.dart';
import 'package:http/http.dart' as http;

class RemiNetworkLoader {
  Future<Service> fetchService(String id) async {
    final response = await http.get(
      Uri.parse('http://192.168.0.177:5050/api/v1/data/settings/$id')
    );

    final imageSrc = await http.get(
      Uri.parse('http://192.168.0.177:5050/api/v1/data/main_image/$id')
    );

    if (response.statusCode == 200) {
      Service service = new Service();
      var decodedJson = jsonDecode(response.body);

      service.title = decodedJson['title'];
      service.address = decodedJson['address'];
      service.stars_count = decodedJson['stars_count'];
      service.type = decodedJson['type'];
      service.main_image = imageSrc.body;

      return service;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load service');
    }
  }
}