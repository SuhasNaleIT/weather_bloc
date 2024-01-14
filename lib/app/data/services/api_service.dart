import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import '../../../utils/constants.dart';
import '../models/fetch_weather.dart';

class ApiService {
  static var client = RetryClient(
    http.Client(),
  );

  static Future<FetchWeatherModel> getWeatherDetails(String searchText) async {
    try {
      var response = await client.get(
        Uri.parse(Constants.searchWeatherAPI + searchText),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print("=======Response in Services==========${response.body}");
      final fetchWeather =
          FetchWeatherModel.fromJson(json.decode(response.body));
      return fetchWeather;
    } catch (e) {
      print("=======Exception in Services==========$e");
      return Future.error(e);
    }
  }
}
