import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<getWeather>((event, emit) async{
      emit(WeatherLoad());
      try {
        WeatherFactory wf = WeatherFactory(
            "ed5b992c8e68de42484986d3bf6499a0", language: Language.ENGLISH);

        //Position position = await Geolocator.getCurrentPosition();

        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude,
            event.position.longitude
        );
        print(weather);
        emit(WeatherSucc(weather));
      } catch (e) {
        emit(WeatherFail());
      }
    });
  }
}
