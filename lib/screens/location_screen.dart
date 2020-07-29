import 'package:flutter/material.dart';
import 'package:aria/utilities/constants.dart';
import 'package:aria/services/weather.dart';
import 'package:aria/screens/city_screen.dart';
import 'package:aria/services/getting_city_name.dart';
import 'package:aria/services/update_city_name.dart';
import 'package:aria/utilities/grid_child_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  CityName cityNameGetMethodtwo = CityName();
  UpdateCity updateCity = UpdateCity();

  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherDescription;

  String cityName;
  //String countryCode;
  int feelsLike;
  int humidity;
  int pressure;
  String visibility;
  int sunRiseHour;
  int sunRiseMinute;
  int sunSetHour;
  int sunSetMinute;
  String windSpeed;
  int windDirection;
  String message;
  String weatherIconImage = 'images/location_background.jpg';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(
      () {
        if (weatherData == null) {
          temperature = 0;
          weatherDescription = 'Data not found!';
          cityName = 'Sorry :(';
          feelsLike = 0;
          humidity = 0;
          windSpeed = '0';
          windDirection = 0;
          sunRiseHour = 0;
          sunRiseMinute = 0;
          sunSetHour = 0;
          sunSetMinute = 0;
          pressure = 0;
          visibility = '0';
          message =
              'Please check your location settings and internet connection';

          return;
        }
        var temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        var condition = weatherData['weather'][0]['id'];

        var fl = weatherData['main']['feels_like'];
        feelsLike = fl.toInt();
        weatherDescription = weatherData['weather'][0]['description'];
        humidity = weatherData['main']['humidity'];
        pressure = weatherData['main']['pressure'];
        var v = weatherData['visibility'] / 1000;
        visibility = v.toStringAsFixed(1);
        var ws = weatherData['wind']['speed'] * 3.6;
        windSpeed = ws.toStringAsFixed(1);
        windDirection = weatherData['wind']['deg'];

        cityName = weatherData['name'];
        // countryCode = weatherData['sys']['country'];
        message = weather.getWeatherMessage(condition);
        weatherIconImage = weather.getWeatherIconImage(condition);
        var sunRiseUnixTime = ((weatherData['sys']['sunrise']) * 1000);
        var sunRiseTime =
            DateTime.fromMillisecondsSinceEpoch(sunRiseUnixTime, isUtc: false);
        sunRiseHour = sunRiseTime.hour;
        sunRiseMinute = sunRiseTime.minute;

        var sunSetUnixTime = ((weatherData['sys']['sunset']) * 1000);
        var sunSetTime =
            DateTime.fromMillisecondsSinceEpoch(sunSetUnixTime, isUtc: false);
        sunSetHour = sunSetTime.hour;
        sunSetMinute = sunSetTime.minute;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff060E2E),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xff060E2E),
              primary: true,
              pinned: true,
              snap: false,
              floating: false,
              centerTitle: true,
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    var typedName = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CityScreen();
                        },
                      ),
                    );
                    if (typedName != null) {
                      var weatherData = await weather.getCityWeather(typedName);
                      updateUI(weatherData);
                    }
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoadingScreen();
                        },
                      ),
                    );
                  },
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ),
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  cityName,
                  style: GoogleFonts.roboto(),
                ),
                background: Container(
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 60.0,
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '$temperature°',
                                style: GoogleFonts.roboto(
                                    textStyle: kTempTextStyle),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                weatherDescription.toUpperCase(),
                                style: GoogleFonts.roboto(
                                  textStyle: kWeatherDescriptionTextStyle,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(13.0),
                            child: Center(
                              child: Image.asset(weatherIconImage),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // If the main content is a list, use SliverList instead.
            SliverPadding(
              padding: EdgeInsets.all(15),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: <Widget>[
                  GridCard(
                    gridChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'FEELS LIKE (°C):',
                          style: GoogleFonts.roboto(
                              textStyle: kGridTitleTextStyle),
                        ),
                        Text(
                          '$feelsLike°',
                          style: kGridInfoTextStyle,
                        ),
                      ],
                    ),
                  ),
                  GridCard(
                    gridChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'HUMIDITY:',
                          style: GoogleFonts.roboto(
                              textStyle: kGridTitleTextStyle),
                        ),
                        Text(
                          '$humidity%',
                          style: kGridInfoTextStyle,
                        ),
                      ],
                    ),
                  ),
                  GridCard(
                    gridChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WIND SPEED (Kph):',
                          style: GoogleFonts.roboto(
                              textStyle: kGridTitleTextStyle),
                        ),
                        Text(
                          windSpeed,
                          style: kGridInfoTextStyle,
                        ),
                      ],
                    ),
                  ),
                  GridCard(
                    gridChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WIND DIRECTION:',
                          style: GoogleFonts.roboto(
                              textStyle: kGridTitleTextStyle),
                        ),
                        Text(
                          '$windDirection°',
                          style: kGridInfoTextStyle,
                        ),
                      ],
                    ),
                  ),
                  GridCard(
                    gridChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'SUNRISE:',
                          style: GoogleFonts.roboto(
                              textStyle: kGridTitleTextStyle),
                        ),
                        Text(
                          '$sunRiseHour:$sunRiseMinute',
                          style: kGridInfoTextStyle,
                        ),
                      ],
                    ),
                  ),
                  GridCard(
                    gridChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'SUNSET:',
                          style: GoogleFonts.roboto(
                              textStyle: kGridTitleTextStyle),
                        ),
                        Text(
                          '$sunSetHour:$sunSetMinute',
                          style: kGridInfoTextStyle,
                        ),
                      ],
                    ),
                  ),
                  GridCard(
                    gridChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'PRESSURE (hPa):',
                          style: GoogleFonts.roboto(
                              textStyle: kGridTitleTextStyle),
                        ),
                        Text(
                          '$pressure',
                          style: kGridInfoTextStyle.copyWith(fontSize: 52),
                        ),
                      ],
                    ),
                  ),
                  GridCard(
                    gridChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'VISIBILITY (Km):',
                          style: GoogleFonts.roboto(
                              textStyle: kGridTitleTextStyle),
                        ),
                        Text(
                          visibility,
                          style: kGridInfoTextStyle.copyWith(fontSize: 52),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.all(9),
              sliver: SliverGrid.count(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          message,
                          style: GoogleFonts.cormorantGaramond(
                              textStyle: kMessageTextStyle),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Developed by Azmal Awasaf',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
