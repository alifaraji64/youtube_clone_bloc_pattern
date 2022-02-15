import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Video {
  static const baseUrl = 'http://10.0.2.2:5000';

  addVideo(String videoUrl, String thumbnailUrl, String jwt) async {
    print('add video');
    final client = http.Client();
    Uri url = Uri.parse(baseUrl + '/addVideo');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response response = await client.post(url,
        headers: {'content-type': 'application/json', 'authorization': jwt},
        body: jsonEncode({
          'videoUrl': videoUrl,
          'thumbnailUrl': thumbnailUrl,
          'userId': prefs.get('uid')
        }));
    client.close();
    if (response.statusCode != 200) {
      return throw CustomException(msg: jsonDecode(response.body)['error']);
    }
  }

  Future<List> getVideos() async {
    final client = http.Client();
    Uri url = Uri.parse(baseUrl + '/getVideos');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('uid');
    print(prefs.get('uid'));
    http.Response response = await client.get(
      url,
      headers: {
        'content-type': 'application/json',
        'uid': prefs.get('uid'),
        'authorization': prefs.get('jwt')
      },
    );
    client.close();
    if (response.statusCode != 200) {
      return throw CustomException(msg: jsonDecode(response.body)['error']);
    }
    return jsonDecode(response.body)['videos'];
    //print(response.body);
  }
}

class CustomException implements Exception {
  final msg;
  const CustomException({this.msg});
}
