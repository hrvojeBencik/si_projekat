import 'package:dio/dio.dart';
import 'package:si_app/config/api.dart';
import 'package:si_app/src/models/user.dart';

class ApiService {
  final Dio dio = Dio();
  Future<void> addUser(User user) async {
    var response = await dio.post(baseUrl + postUser, data: user.toJson());
  }
}
