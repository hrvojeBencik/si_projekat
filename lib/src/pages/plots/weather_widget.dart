import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:si_app/src/constants/colors.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/models/weather.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key? key, required this.weather, required this.reloadWeather}) : super(key: key);

  final Weather weather;
  final Function() reloadWeather;

  @override
  Widget build(BuildContext context) {
    AppLocalizations _localization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Image.network(
            weather.iconUrl!,
            scale: 0.5,
          ),
          Text(
            weather.weatherDescription.replaceFirst(weather.weatherDescription[0], weather.weatherDescription[0].toUpperCase()),
            style: FructifyStyles.textStyle.messageStyle,
          ),
          Text(
            weather.currentTemp.toStringAsFixed(1) + '°C',
            style: FructifyStyles.textStyle.messageStyle.copyWith(
              fontSize: 28,
              color: FructifyColors.lightGreen,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Vlaznost vazduha: ${weather.humidity}%",
            style: FructifyStyles.textStyle.messageStyle.copyWith(
              fontSize: 18,
            ),
          ),
          Text(
            "Pritisak: ${weather.pressure} hPa",
            style: FructifyStyles.textStyle.messageStyle.copyWith(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width > 1400 ? double.infinity : 600,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemExtent: 60,
              cacheExtent: 100,
              itemCount: weather.hourlyWeather.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _hourlyWeatherWidget(weather.hourlyWeather[index]);
              },
            ),
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: () => reloadWeather(),
            icon: const Icon(
              Icons.replay_outlined,
              color: FructifyColors.lightGreen,
            ),
            label: Text(
              _localization.reload,
              style: const TextStyle(
                color: FructifyColors.lightGreen,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hourlyWeatherWidget(HourlyWeather hw) {
    return Column(
      children: [
        Image.network(hw.iconUrl!),
        Text(
          hw.temp.toStringAsFixed(1) + '°C',
          style: const TextStyle(
            color: FructifyColors.darkGreen,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: DateFormat('dd/MM\n').format(hw.date),
              style: const TextStyle(
                color: FructifyColors.lightGreen,
                fontSize: 10,
              ),
            ),
            TextSpan(
              text: DateFormat('HH:mm').format(hw.date),
              style: const TextStyle(
                color: FructifyColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
