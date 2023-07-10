import 'package:flutter/material.dart';

class Constants {
  //******* API URL *****/

  static String apiKey = '08a24337f0e648bfa08122626230807';
  static String searchWeatherAPI =
      "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&days=7&q=";

  //****** IMAGES CONSTANTS ********/
  static const sliderImg1 = "assets/images/sliders/onboard1.png";
  static const sliderImg2 = "assets/images/sliders/onboard2.png";
  static const pin = "assets/images/pin.png";
  static const clear = "assets/images/status/clear.png";
  static const cloud = "assets/images/status/cloud.png";
  static const cloudy = "assets/images/status/cloudy.png";
  static const fog = "assets/images/status/fog.png";
  static const heavycloudy = "assets/images/status/heavycloudy.png";
  static const heavyrain = "assets/images/status/heavyRain.png";
  static const humidity = "assets/images/status/humidity.png";
  static const lightdrizzle = "assets/images/status/lightdrizzle.png";
  static const lightrain = "assets/images/status/lightrain.png";
  static const lightrainshower = "assets/images/status/lightrainshower.png";
  static const mist = "assets/images/status/mist.png";
  static const moderateorheavyrainshower =
      "assets/images/status/moderateorheavyrainshower.png";
  static const moderateorheavyrainwiththunder =
      "assets/images/status/moderateorheavyrainwiththunder.png";
  static const moderaterain = "assets/images/status/moderaterain.png";
  static const moderaterainattimes =
      "assets/images/status/moderaterainattimes.png";
  static const overcast = "assets/images/status/overcast.png";
  static const partlycloudy = "assets/images/status/partlycloudy.png";
  static const patchylightdrizzle =
      "assets/images/status/patchylightdrizzle.png";
  static const patchylightrain = "assets/images/status/patchylightrain.png";
  static const patchylightrainwiththunder =
      "assets/images/status/patchylightrainwiththunder.png";
  static const patchyrainpossible =
      "assets/images/status/patchyrainpossible.png";
  static const sunny = "assets/images/status/sunny.png";
  static const thunderyoutbreakspossible =
      "assets/images/status/thunderyoutbreakspossible.png";
  static const torrentialrainshower =
      "assets/images/status/torrentialrainshower.png";
  static const windspeed = "assets/images/status/windspeed.png";

  //******** SLIDERS CONSTANTS *********/
  // static var swipeIndex = 0;
  static List<List<dynamic>> slides = [
    [
      sliderImg1,
      "Weather Watch",
      "Get weather information on the go.",
    ],
    [
      sliderImg2,
      "Your Forecasting Friend",
      "Stay ahead of the weather and stay safe.",
    ],
  ];

  static List cardSlides = [
    sliderImg1,
    sliderImg2,
  ];
}
