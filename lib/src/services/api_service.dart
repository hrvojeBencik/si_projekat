import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:si_app/config/api.dart';
import 'package:si_app/src/models/user.dart';

class ApiService {
  final Dio dio = Dio();

  final Options _options = Options(headers: {
    'Authorization': 'Basic ' + base64Encode(utf8.encode('$user:$password')),
  });

  Future<void> addUser(User user) async {
    var response = await dio.post(
      baseUrl + postUser,
      data: user.toJson(),
      options: _options,
    );
    log(response.toString());
  }
}
