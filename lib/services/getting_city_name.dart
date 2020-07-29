import 'package:aria/services/location.dart';
import 'package:aria/services/networking.dart';

//We are going to fetch the City Name from LocationIQ API and call the openweathermap API with that city name to get the weather data. Because openweathermap API does not always show the correct city name in the weather data.

//TODO: Get your free reverse geocoding API Key from 'locationiq.com ' and assign the string value to 'apiKey' variable.
const apiKey = '';
const locationIQURL = 'https://us1.locationiq.com/v1/reverse.php';

class CityName {
  Future<dynamic> getCityName() async {
    Location location = Location();
    await location.getCurrentLocation();

    print(location.latitude);
    print(location.longitude);

    NetworkHelper networkHelper = NetworkHelper(
        '$locationIQURL?key=$apiKey&lat=${location.latitude}&lon=${location.longitude}&format=json');

    var cityNameData = await networkHelper.getData();
    return cityNameData;
  }

  Future<String> getCityData() async {
    var cityData = await CityName().getCityName();
    return cityData['address']['city'];
  }
}
