import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../utils/color_theme.dart';
import '../../../utils/constants.dart';
import '../../data/services/formatter.dart';
// import '../details/details.dart';
import '../widgets/weather_item.dart';
// import 'bloc/location bloc/bloc/location_bloc.dart';
import 'bloc/weather bloc/weather_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherBloc weatherBloc = WeatherBloc();

  String weatherIcon = 'heavycloud.png';

  String location = "Mumbai";

  @override
  void initState() {
    // weatherBloc.add(WeatherFetchInital(location: "Mumbai"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: weatherBloc,
        builder: (context, state) {
          if (state is WeatherInitial) {
            weatherBloc.add(WeatherFetchInital(location: "mumbai"));
          }
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WeatherDetailsErrorState) {
            return Scaffold(
              body: Center(
                  child: Column(
                children: [
                  Text(
                    state.errMsg,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                      onPressed: () {
                        weatherBloc.add(WeatherFetchInital(location: "Mumbai"));
                      },
                      icon: const Icon(
                        Icons.replay_rounded,
                        weight: 2,
                      ))
                ],
              )),
            );
          }
          if (state is WeatherDetailsFetchedState) {
            final data = state.fetchWeather;
            final dailyWeatherForecast = data.forecast.forecastday;
            final hourlyWeatherForecast = dailyWeatherForecast[0].hour;
            return Column(
              children: [
                Container(
                  height: size.height * 0.75,
                  width: size.width,
                  // margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        Constants.topBg,
                      ),
                    ),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Constants.pin,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data.location.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _cityController.clear();
                                showMaterialModalBottomSheet(
                                  context: context,
                                  builder: (context) => Builder(
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        controller:
                                            ModalScrollController.of(context),
                                        child: Container(
                                          height: size.height * 0.5,
                                          width: size.width,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.35,
                                                child: Divider(
                                                  thickness: 3.5,
                                                  color:
                                                      ColorTheme.kPrimaryColor,
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: size.width * 0.65,
                                                    child: TextField(
                                                      onChanged: (searchText) {
                                                        // fetchDetails(searchText);
                                                        // fetchWeatherData(searchText);
                                                      },
                                                      controller:
                                                          _cityController,
                                                      autofocus: true,
                                                      decoration:
                                                          InputDecoration(
                                                        prefixIcon: Icon(
                                                          Icons.search,
                                                          color: ColorTheme
                                                              .kPrimaryColor,
                                                          size: 30,
                                                        ),
                                                        prefixIconConstraints:
                                                            const BoxConstraints(
                                                          minHeight: 32,
                                                          minWidth: 35,
                                                        ),
                                                        suffixIcon:
                                                            GestureDetector(
                                                          onTap: () =>
                                                              _cityController
                                                                  .clear(),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: ColorTheme
                                                                .kPrimaryColor,
                                                            size: 30,
                                                          ),
                                                        ),
                                                        isDense: true,
                                                        hintText:
                                                            'Search city e.g. London',
                                                        hintStyle:
                                                            const TextStyle(
                                                                fontSize: 14),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: ColorTheme
                                                                .kPrimaryColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.02,
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.07,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            ColorTheme
                                                                .kPrimaryColor,
                                                      ),
                                                      onPressed: () {
                                                        weatherBloc.add(
                                                          WeatherFetchInital(
                                                            location:
                                                                _cityController
                                                                    .text,
                                                          ),
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Submit',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        data.current.condition.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      SizedBox(
                        height: 160,
                        child: Image.asset(
                          Constants.basicImage +
                              Formatter.formatImage(
                                  data.current.condition.text),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              data.current.tempC.toString(),
                              style: const TextStyle(
                                fontSize: 80,
                                // fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    offset: Offset(0, 0),
                                    color: Color.fromRGBO(255, 255, 255, 0.4),
                                  ),
                                  Shadow(
                                    blurRadius: 6,
                                    offset: Offset(4, 2),
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                  )
                                ],
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Text(
                            'o',
                            style: TextStyle(
                              fontSize: 40,
                              // fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  offset: Offset(0, 0),
                                  color: Color.fromRGBO(255, 255, 255, 0.4),
                                ),
                                Shadow(
                                  blurRadius: 6,
                                  offset: Offset(4, 2),
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                )
                              ],
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'C',
                              style: TextStyle(
                                fontSize: 80,
                                // fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    offset: Offset(0, 0),
                                    color: Color.fromRGBO(255, 255, 255, 0.4),
                                  ),
                                  Shadow(
                                    blurRadius: 6,
                                    offset: Offset(4, 2),
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                  )
                                ],
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        Formatter.formatDate(data.location.localtime),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Divider(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WeatherItem(
                              value: data.current.windKph.toInt(),
                              unit: 'km/h',
                              imageUrl: Constants.windspeed,
                            ),
                            WeatherItem(
                              value: data.current.humidity.toInt(),
                              unit: '%',
                              imageUrl: Constants.humidity,
                            ),
                            WeatherItem(
                              value: data.current.cloud.toInt(),
                              unit: '%',
                              imageUrl: Constants.cloud,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //************* HOURLY FORECAST ***********/
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  height: size.height * .22,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: ColorTheme.kPrimaryColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.vibrate();
                              //********** SNACKBAR ************/
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'This Functionality is Under Progress !!!',
                                    style: TextStyle(
                                      color: ColorTheme.kPrimaryColor,
                                    ),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height -
                                        100,
                                    left: 10,
                                    right: 10,
                                  ),
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: ColorTheme.kOnboardingColor,
                                  action: SnackBarAction(
                                    label: 'dismiss',
                                    onPressed: () {},
                                  ),
                                ),
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Details(
                              //       data: data,
                              //     ),
                              //   ),
                              // );
                            }, //this will open forecast screen
                            child: Text(
                              'Forecasts',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ColorTheme.kPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 110,
                        child: ListView.builder(
                          itemCount: hourlyWeatherForecast.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            String currentTime =
                                DateFormat('HH:mm:ss').format(DateTime.now());
                            String currentHour = currentTime.substring(0, 2);

                            String forecastTime = hourlyWeatherForecast[index]
                                .time
                                .substring(11, 16);
                            String forecastHour = hourlyWeatherForecast[index]
                                .time
                                .substring(11, 13);

                            String forecastWeatherName =
                                hourlyWeatherForecast[index]
                                    .condition
                                    .text
                                    .toString();
                            String forecastWeatherIcon =
                                "${forecastWeatherName.replaceAll(' ', '').toLowerCase()}.png";

                            String forecastTemperature =
                                hourlyWeatherForecast[index]
                                    .tempC
                                    .round()
                                    .toString();
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              margin: const EdgeInsets.only(right: 20),
                              width: 65,
                              decoration: BoxDecoration(
                                  color: currentHour == forecastHour
                                      ? Colors.white
                                      : ColorTheme.kListView,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 1),
                                      blurRadius: 5,
                                      color: ColorTheme.kPrimaryColor
                                          .withOpacity(.2),
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    forecastTime,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: ColorTheme.kTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Image.asset(
                                    Constants.basicImage +
                                        Formatter.formatImage(data
                                            .current.condition.text
                                            .toString()),
                                    width: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        forecastTemperature,
                                        style: TextStyle(
                                          color: ColorTheme.kTextColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'o',
                                        style: TextStyle(
                                          color: ColorTheme.kTextColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                          fontFeatures: const [
                                            FontFeature.enable('sups'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container(
            color: Colors.black,
          );
        },
      ),
    );
  }
}
