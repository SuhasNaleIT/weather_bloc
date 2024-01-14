import 'package:bloc/bloc.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import '../../../../data/models/fetch_weather.dart';
import '../../../../data/services/api_service.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherFetchInital>(initial);
    // on<GetLocationEvent>(_getCurrentLocation);
  }

  void initial(WeatherFetchInital event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final FetchWeatherModel fetchWeather =
          await ApiService.getWeatherDetails(event.location);
      emit(WeatherDetailsFetchedState(fetchWeather));
    } catch (e) {
      emit(WeatherDetailsErrorState("Something went wrong!"));
    }
  }

  // late double lat;
  // late double long;

  // void _getCurrentLocation(
  //     GetLocationEvent event, Emitter<WeatherState> emit) async {
  //   print("Inside Geolocation");
  //   LocationPermission permission = await Geolocator.requestPermission();
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) async {
  //     //Pass the lat and long to the function

  //     List<Placemark> p =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);

  //     Placemark place = p[0];

  //     String location = place.locality.toString();

  //     emit(GetLocationState(location: location));
  //     // WeatherBloc().add(WeatherFetchInital(location: location));
  //     lat = position.altitude;
  //     long = position.longitude;

  //     print("Lat: " + lat.toString() + "Long: " + long.toString());
  //     print(location.toString());
  //   }).catchError((e) {
  //     emit(GetLocationErrorState(e));
  //     // WeatherBloc().add(WeatherFetchInital(location: 'Mumbai'));
  //     print(e);
  //   });
  // }
}
