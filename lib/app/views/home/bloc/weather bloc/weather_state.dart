part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {
  WeatherInitial();
}

class WeatherLoading extends WeatherState {
  WeatherLoading();
}

class WeatherDetailsFetchedState extends WeatherState {
  final FetchWeatherModel fetchWeather;
  WeatherDetailsFetchedState(this.fetchWeather);
}

class WeatherDetailsErrorState extends WeatherState {
  final String errMsg;
  WeatherDetailsErrorState(this.errMsg);
}

class GetLocationState extends WeatherState {
  final String location;
  GetLocationState({required this.location});
}

class GetLocationErrorState extends WeatherState {
  final String msg;
  GetLocationErrorState(this.msg);
}
