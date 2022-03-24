import 'dart:convert';

import 'package:http/http.dart' as http;

class Authentication {
  static const baseUrl = 'http://10.0.2.2:5000';
  Future<String> register(
      String username, String email, String password) async {
    final client = http.Client();
    Uri url = Uri.parse(baseUrl + '/auth/register');
    http.Response response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {"username": username, "email": email, "password": password}),
    );
    client.close();
    if (response.statusCode != 200) {
      return throw NetworkException(jsonDecode(response.body)['error']);
    }
    return jsonDecode(response.body)['token'];
    //print(jsonDecode(response.body)['error']);
  }

  Future<String> login(String username, String password) async {
    final client = http.Client();
    Uri url = Uri.parse(baseUrl + '/auth/login');
    http.Response response = await client.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"username": username, "password": password}));
    client.close();
    if (response.statusCode != 200) {
      print(jsonDecode(response.body)['error']);
      return throw NetworkException(jsonDecode(response.body)['error']);
    }
    return jsonDecode(response.body)['token'];
  }
}

class NetworkException implements Exception {
  final msg;
  const NetworkException(this.msg);
}
