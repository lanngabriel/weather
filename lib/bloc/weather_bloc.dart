import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:weatherFK/screen/citysearch.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  String? cityname;

  WeatherBloc() : super(WeatherInitial()) {
    on<getWeather>((event, emit) async{
      emit(WeatherLoad());
      try {
        WeatherFactory wf = WeatherFactory(
            "ed5b992c8e68de42484986d3bf6499a0", language: Language.ENGLISH);

        if (event.city != null && event.city != cityname && event.city != '1') {
          cityname = event.city;
          Weather weather = await wf.currentWeatherByCityName(event.city!);
          print(weather);
          emit(WeatherSucc(weather));
        }
        else if (event.city == '1'){
          Weather weather = await wf.currentWeatherByLocation(
              event.position.latitude,
              event.position.longitude
          );
          print(weather);
          emit(WeatherSucc(weather));
        }
        else {
          Weather weather = await wf.currentWeatherByLocation(
              event.position.latitude,
              event.position.longitude
          );
          print(weather);
          emit(WeatherSucc(weather));
        }
      } catch (e) {
        emit(WeatherFail());
      }
    });
  }
}
