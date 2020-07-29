import 'package:aria/services/location.dart';
import 'package:aria/services/networking.dart';

//TODO: Get your free API Key from 'openweathermap.org' to get current weather data for your location and assign the string value to 'apiKey' variable.

const apiKey = '9ee46dfa4adc92cfedd91cfba2decbb9';
const openWeathermapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeathermapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeathermapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  ///Details about "Codition" are available in openweathermap API Docs.

  String getWeatherMessage(int condition) {
    if (condition < 300) {
      return '"Looks like it\'s thunderstorms today. Stay cautious!"';
    } else if (condition < 400) {
      return '"It\'s drizzling outsize. Don\'t forget the Umbrella!"';
    } else if (condition < 600) {
      return '"Looks like a rainy day. It\'s Khichuri Time!"️';
    } else if (condition < 700) {
      return '"Time to build a Snowman. Don\'t forget the warm clothes!"️';
    } else if (condition < 800) {
      return '"The sky looks good. Still there is no guarantee!"️';
    } else if (condition == 800) {
      return '"The sky is clear. Have a good day!"️';
    } else if (condition <= 804) {
      return '"The sky looks cloudy. Don\'t forget the Umbrella!"️';
    } else {
      return '"Weather seems unpredictable today. Take an umbrella just in case!"️';
    }
  }

  String getWeatherIconImage(int condition) {
    if (condition < 300) {
      return 'images/thunder.png';
    } else if (condition < 400) {
      return 'images/drizzle.png';
    } else if (condition < 600) {
      return 'images/rain.png';
    } else if (condition < 700) {
      return 'images/snow.png';
    } else if (condition < 800) {
      return 'images/atmosphere.png';
    } else if (condition == 800) {
      return 'images/clear.png';
    } else if (condition <= 804) {
      return 'images/cloud.png';
    } else {
      return 'images/atmosphere.png';
    }
  }
}
