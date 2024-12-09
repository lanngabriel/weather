part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoad extends WeatherState {}
final class WeatherFail extends WeatherState {}
final class WeatherSucc extends WeatherState {
  final Weather weather;

  WeatherSucc(this.weather);


}
