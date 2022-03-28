import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/data/models/User.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class UserInfo {
  static const baseUrl = 'https://353b-173-255-193-98.ngrok.io';
  Future<User> fetchUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    final client = http.Client();
    Uri url = Uri.parse(baseUrl + '/userInfo');
    http.Response response = await client.get(url,
        headers: {'content-type': 'application/json', 'authorization': jwt});
    if (response.statusCode != 200) {
      return throw CustomException(jsonDecode(response.body)['error']);
    }
    return User.fromJson(jsonDecode(response.body));
  }

  Future pickImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result == null) return CustomException("you didn't select any image");
    print(result);
    //returning the path of the selected file, so we can wrap it with File in cubit
    return result.files.single.path;
  }

  Future pickVideo() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );
    if (result == null) return CustomException("you didn't select any video");
    print(result);
    return result.files.single.path;
  }

  Future addProfileImage(String profileImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwt = prefs.getString('jwt');
    final client = http.Client();
    Uri url = Uri.parse(baseUrl + '/addProfileImage');
    http.Response response = await client.post(
      url,
      headers: {'content-type': 'application/json', 'authorization': jwt},
      body: jsonEncode({"profileImage": profileImage}),
    );
    if (response.statusCode != 200) {
      return throw CustomException(jsonDecode(response.body)['error']);
    }
  }
}

class CustomException implements Exception {
  final msg;
  const CustomException(this.msg);
}
