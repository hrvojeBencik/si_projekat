import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:si_app/config/api.dart';
import 'package:si_app/src/models/plot.dart';
import 'package:si_app/src/models/tillage.dart';
import 'package:si_app/src/models/user.dart';
import 'package:si_app/src/models/watering.dart';
import 'package:si_app/src/services/authentication/user_repository.dart';

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

  Future<List<Plot>> getAllPlots() async {
    try {
      var response = await _dio.get(
        baseUrl + plotsEndpoint + '/user/${UserRepository().getFirebaseId()}',
      );

      List data = response.data as List;

      if (data.isNotEmpty) {
        List<Plot>? _plots = getAllPlotsFromJson(response.data);
        return _plots;
      }

      return [];
    } catch (e) {
      log('Api Service getAllPlots exception: ${e.toString()}');
      return [];
    }
  }

  Future<Plot?> addNewPlot(Plot plot) async {
    try {
      var response = await _dio.post(
        baseUrl + plotsEndpoint,
        data: json.encode(plot.toJson()),
      );

      Plot _plot = Plot.fromJson(response.data);

      return _plot;
    } catch (e) {
      log('Api Service addNewPlot exception: ${e.toString()}');
      return null;
    }
  }

  Future<Tillage?> addNewTillage(Tillage tillage) async {
    try {
      var response = await _dio.post(
        baseUrl + tillageEndpoint,
        data: json.encode(tillage.toJson()),
      );

      Tillage _tillage = Tillage.fromJson(response.data);

      return _tillage;
    } catch (e) {
      log('Api Service addNewTillage exception: ${e.toString()}');
      return null;
    }
  }

  Future<List<Tillage>> getTillagesByPlot(String plotId) async {
    try {
      var response = await _dio.get(
        baseUrl + tillageEndpoint + '/plot/$plotId',
      );

      List<Tillage> _tillages = getTillagesFromJson(response.data);

      return _tillages;
    } catch (e) {
      log('Api Service addNewTillage exception: ${e.toString()}');
      return [];
    }
  }

  Future<Watering?> addNewWatering(Watering watering) async {
    try {
      var response = await _dio.post(
        baseUrl + wateringEndpoint,
        data: json.encode(watering.toJson()),
      );

      Watering _watering = Watering.fromJson(response.data);

      return _watering;
    } catch (e) {
      log('Api Service addNewTillage exception: ${e.toString()}');
      return null;
    }
  }

  Future<List<Watering>> getWateringsByPlot(String plotId) async {
    try {
      var response = await _dio.get(
        baseUrl + wateringEndpoint + '/plot/$plotId',
      );

      List<Watering> _waterings = getWateringsFromJson(response.data);

      return _waterings;
    } catch (e) {
      log('Api Service addNewTillage exception: ${e.toString()}');
      return [];
    }
  }
}
