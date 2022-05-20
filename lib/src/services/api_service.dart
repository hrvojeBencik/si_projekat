import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:si_app/config/api.dart';
import 'package:si_app/src/models/care.dart';
import 'package:si_app/src/models/plot.dart';
import 'package:si_app/src/models/supplementation.dart';
import 'package:si_app/src/models/tillage.dart';
import 'package:si_app/src/models/user.dart';
import 'package:si_app/src/models/watering.dart';
import 'package:si_app/src/models/yield.dart';
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
      log('Api Service getTillagesByPlot exception: ${e.toString()}');
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
      log('Api Service getWateringsByPlot exception: ${e.toString()}');
      return [];
    }
  }

  Future<Care?> addNewCare(Care care) async {
    try {
      var response = await _dio.post(
        baseUrl + careEndpoint,
        data: json.encode(care.toJson()),
      );

      Care _care = Care.fromJson(response.data);

      return _care;
    } catch (e) {
      log('Api Service addNewCare exception: ${e.toString()}');
      return null;
    }
  }

  Future<List<Care>> getCaresByPlot(String plotId) async {
    try {
      var response = await _dio.get(
        baseUrl + careEndpoint + '/plot/$plotId',
      );

      List<Care> _cares = getCaresFromJson(response.data);

      return _cares;
    } catch (e) {
      log('Api Service getCaresByPlot exception: ${e.toString()}');
      return [];
    }
  }

  Future<Supplementation?> addNewSupplementation(Supplementation supplementation) async {
    try {
      var response = await _dio.post(
        baseUrl + supplementationEndpoint,
        data: json.encode(supplementation.toJson()),
      );

      Supplementation _supplementation = Supplementation.fromJson(response.data);

      return _supplementation;
    } catch (e) {
      log('Api Service addNewSupplementation exception: ${e.toString()}');
      return null;
    }
  }

  Future<List<Supplementation>> getSupplementationsByPlot(String plotId) async {
    try {
      var response = await _dio.get(
        baseUrl + supplementationEndpoint + '/plot/$plotId',
      );

      List<Supplementation> _supplementations = getSupplementationsFromJson(response.data);

      return _supplementations;
    } catch (e) {
      log('Api Service getAllSupplementationsByPlot exception: ${e.toString()}');
      return [];
    }
  }

  Future<Yield?> addNewYield(Yield y) async {
    try {
      var response = await _dio.post(
        baseUrl + yieldEndpoint,
        data: json.encode(y.toJson()),
      );

      Yield _yield = Yield.fromJson(response.data);

      return _yield;
    } catch (e) {
      log('Api Service addNewYield exception: ${e.toString()}');
      return null;
    }
  }

  Future<List<Yield>> getYieldsByPlot(String plotId) async {
    try {
      var response = await _dio.get(
        baseUrl + yieldEndpoint + '/plot/$plotId',
      );

      List<Yield> _yields = getYieldsFromJson(response.data);

      return _yields;
    } catch (e) {
      log('Api Service getAllYieldsByPlot exception: ${e.toString()}');
      return [];
    }
  }

  Future<void> deleteInstanceById(String endpoint, String instanceId) async {
    try {
      await _dio.delete(baseUrl + endpoint + '/$instanceId');
    } catch (e) {
      log('Api Service deleteINstanceById exception: ${e.toString()}');
    }
  }

  Future<void> updateUser(Map<String, dynamic> userData, String userId) async {
    try {
      await _dio.patch(
        baseUrl + userEndpoint + '/$userId',
        data: json.encode(
          userData,
        ),
      );
    } catch (e) {
      log('Api Service updateUser exception: ${e.toString()}');
    }
  }
}
