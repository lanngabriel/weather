part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}


class getWeather extends WeatherEvent {
  final Position position;

  getWeather(this.position);

}