import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:si_app/src/models/weather.dart';

class WeatherService {
  static const String _apiKey = 'c26ac3f1fef3d0acaa004b405fe4b107';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _weatherIconUrl = 'http://openweathermap.org/img/w/';
  static const String _pngExtension = '.png';
  static const String _weatherEndpoint = '/weather';
  static const String _forecast = '/forecast';
  static const String _units = 'metric';
  static const String _lang = 'hr';
  final Dio _dio = Dio();

  Future<Weather?> getCurrentWeatherByCoordinates(LatLng coordinates) async {
    try {
      final response = await _dio.get(
        _baseUrl + _weatherEndpoint,
        queryParameters: {
          'units': _units,
          'lang': _lang,
          'appId': _apiKey,
          'lat': coordinates.latitude,
          'lon': coordinates.longitude,
        },
      );
      final Weather _weather = Weather.fromJson(response.data);
      _weather.setIcon = _weatherIconUrl + _weather.weatherIconCode + _pngExtension;

      final List<HourlyWeather>? _hourlyWeathers = await getHourlyWeatherByCoordinates(coordinates);
      if (_hourlyWeathers != null) {
        _weather.setHourlyWeather = _hourlyWeathers;
      }

      return _weather;
    } catch (e) {
      log('GetCurrentWeatherByCoordinates exception: ${e.toString()}');
      return null;
    }
  }

  Future<List<HourlyWeather>?> getHourlyWeatherByCoordinates(LatLng coordinates) async {
    try {
      final response = await _dio.get(
        _baseUrl + _forecast,
        queryParameters: {
          'units': _units,
          'lang': _lang,
          'appId': _apiKey,
          'lat': coordinates.latitude,
          'lon': coordinates.longitude,
        },
      );

      final List<HourlyWeather> _weathers = getHoulyWeathersFromJson(response.data['list']);

      for (var item in _weathers) {
        item.setIcon = _weatherIconUrl + item.weatherIconCode + _pngExtension;
      }

      return _weathers;
    } catch (e) {
      log('GetCurrentWeatherByCoordinates exception: ${e.toString()}');
      return null;
    }
  }
}
