/* ----------------------- Imports ---------------------- */
// Dart/Flutter packages
import 'dart:convert';
import 'package:flutter/foundation.dart';
// Pub.dev packages
import 'package:http/http.dart' as http;
// Internal modules
import 'package:pokedex_flutter/app/services/api.dart';

class APIServices {
  /* ----------------- Instance Variables ----------------- */
  // constructor
  final API api;

  APIServices({@required this.api});

  // send request and parse response json body
  Future<Map<String, dynamic>> getEndpointData({
    @required Endpoint endpoint,
  }) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(uri.toString());
    final Map<String, dynamic> body = json.decode(response.body);
    return body;
  }
}
