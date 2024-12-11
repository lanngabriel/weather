
part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class getWeather extends WeatherEvent {
  final Position position;  // User's location
  final String? city;       // City name (optional)

  getWeather({required this.position, this.city});

  @override
  List<Object?> get props => [position, city];
}
