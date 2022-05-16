import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:si_app/config/api.dart';
import 'package:si_app/src/models/user.dart';

class ApiService {
  final Dio _dio = Dio();
  Future<User?> addUser(User user) async {
    try {
      var response = await _dio.post(
        baseUrl + userEndpoint,
        data: json.encode(user.toJson()),
      );

      User _user = User.fromJson(response.data);

      return _user;
    } catch (e) {
      log('Api Service addUser exception: ${e.toString()}');
      return null;
    }
  }

  Future<User?> getUserByFirebaseId(String firebaseId) async {
    try {
      var response = await _dio.get(
        baseUrl + userEndpoint + '/$firebaseId',
      );

      User _user = User.fromJson(response.data);

      return _user;
    } catch (e) {
      log('Api Service getUserByFirebaseId exception: ${e.toString()}');
      return null;
    }
  }
}
