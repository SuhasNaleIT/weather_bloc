part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class WeatherFetchInital extends WeatherEvent {
  final String location;
  WeatherFetchInital({required this.location});
}

class GetLocationEvent extends WeatherEvent {}
