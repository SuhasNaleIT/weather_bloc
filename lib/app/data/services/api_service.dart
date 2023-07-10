import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../../utils/constants.dart';
import '../models/fetch_weather.dart';

class ApiService {
  static var client = RetryClient(
    http.Client(),
  );

  static Future<FetchWeather?> getWeatherDetails(String searchText) async {
    var response = await client.get(
      Uri.parse(Constants.searchWeatherAPI + searchText),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print("=======Response in Services==========" + response.body.toString());
      return fetchWeatherFromJson(response.body);
    } else {
      return null;
    }
  }
}
