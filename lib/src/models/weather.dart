class Weather {
  final String location;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIconCode;
  final double currentTemp;
  final double pressure;
  final double humidity;
  String? iconUrl;
  List<HourlyWeather> hourlyWeather = [];

  Weather({
    required this.location,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIconCode,
    required this.currentTemp,
    required this.pressure,
    required this.humidity,
    this.iconUrl,
  });

  set setIcon(String iconUrl) => this.iconUrl = iconUrl;

  set setHourlyWeather(List<HourlyWeather> hourlyWeather) => this.hourlyWeather = hourlyWeather;

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
      location: data['name'],
      weatherMain: data['weather'][0]['main'],
      weatherDescription: data['weather'][0]['description'],
      weatherIconCode: data['weather'][0]['icon'],
      currentTemp: data['main']['temp'],
      pressure: data['main']['pressure'],
      humidity: data['main']['humidity'],
    );
  }
}

List<HourlyWeather> getHoulyWeathersFromJson(Iterable data) {
  return List<HourlyWeather>.from(data.map((model) => HourlyWeather.fromJson(model)));
}

class HourlyWeather {
  final String weatherDescription;
  final String weatherIconCode;
  final double temp;
  final DateTime date;
  String? iconUrl;

  HourlyWeather({
    required this.weatherDescription,
    required this.weatherIconCode,
    required this.temp,
    required this.date,
    this.iconUrl,
  });

  set setIcon(String iconUrl) => this.iconUrl = iconUrl;

  factory HourlyWeather.fromJson(Map<String, dynamic> data) {
    return HourlyWeather(
      weatherDescription: data['weather'][0]['description'],
      weatherIconCode: data['weather'][0]['icon'],
      temp: data['main']['temp'],
      date: DateTime.parse(data['dt_txt']),
    );
  }
}
