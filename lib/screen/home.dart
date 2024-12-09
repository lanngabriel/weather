import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weatherFK/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  // for animating
  //double cTPosition = -0.3;
  //double cLPosition = 3;
  //double rTPosition = -1.2;
  //double rLPosition = 0;

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >=200 && <= 232: //thunderstorm
        return Image.asset(
          'ass/1.png'
        );
      case >=300 && <= 321: //drizzle
        return Image.asset(
            'ass/2.png'
        );
      case >=500 && <= 531: //rain
        return Image.asset(
            'ass/3.png'
        );
      case >=600 && <= 622: //snow
        return Image.asset(
            'ass/4.png'
        );
      case >=700 && <= 781: //atmosphere
        return Image.asset(
            'ass/5.png'
        );
      case == 800:  //clear
        return Image.asset(
            'ass/6.png'
        );
      case >800 && <= 804:  //clouds
        return Image.asset(
            'ass/8.png'
        );
      default:
        return Image.asset(
          'ass/7.png'
        );
    }
  }
  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300, width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300, width: 600,
                  decoration: const BoxDecoration(
                    //shape: BoxShape.circle,
                    color: Color(0xFFFFAB40),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc,WeatherState>(
                builder: (context, state) {
                  if (state is WeatherSucc) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.weather.areaName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            getGreetingMessage(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          getWeatherIcon(state.weather.weatherConditionCode!),
                          Center(
                            child: Text(
                              '${state.weather.temperature!.celsius!.round()}°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${state.weather.weatherMain}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE, MMMM d').format(state.weather.date!),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherBuilder('Sunrise', DateFormat().add_jm().format(state.weather.sunrise!), 'ass/11.png'),
                              WeatherBuilder('Sunset', DateFormat().add_jm().format(state.weather.sunset!), 'ass/12.png'),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Divider(color: Colors.grey),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherBuilder('Max Temp', '${state.weather.tempMax!.celsius!.round()}°C', 'ass/13.png'),
                              WeatherBuilder('Min Temp', '${state.weather.tempMin!.celsius!.round()}°C', 'ass/14.png'),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Scaffold(
                        body: Center(
                            child: CircularProgressIndicator()
                        )
                    );
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget WeatherBuilder(String title, String value, String iconic) {
  return Row(
    children: [
      Image.asset(iconic, scale: 8),
      const SizedBox(width: 5),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ],
  );
}
