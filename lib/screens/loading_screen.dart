import 'package:aria/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:aria/services/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:aria/services/getting_city_name.dart';
import 'package:aria/services/update_city_name.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  CityName cityNameGetMethod = CityName();
  UpdateCity updateCity = UpdateCity();
  String cityName;

  void getLocationData() async {
    cityName = updateCity.updateCityName(
      await cityNameGetMethod.getCityData(),
    );

    var weatherData = await WeatherModel().getCityWeather(cityName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        },
      ),
    );
  }

  @override
  void initState() {
    print('init called');
    super.initState();

    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff060E2E),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'This texts Should not be seen',
              style: TextStyle(
                color: Color(0xff060E2E),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Image.asset(
                    'images/app.png',
                    height: 150,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Aria',
                  style: kGridInfoTextStyle.copyWith(fontSize: 35),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 0.0,
            ),
            Column(
              children: <Widget>[
                Center(
                  child: SpinKitRing(
                    color: Colors.white70,
                    size: 60.0,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: Text(
                    'Fetching Weather Data...',
                    style: GoogleFonts.roboto(
                      textStyle: kGridTitleTextStyle.copyWith(
                          fontSize: 20.0, color: Colors.white),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                'Developed by Azmal Awasaf',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
