class UpdateCity {
  String updateCityName(String cityName) {
    if (cityName == 'Chattogram') {
      return 'Chittagong';
    }
    if (cityName == 'Barishal') {
      return 'Barisal';
    }
    if (cityName == 'Cumilla') {
      return 'Comilla';
    }
    if (cityName == 'Jashore') {
      return 'Jessore';
    }
    if (cityName == 'Bogura') {
      return 'Bogra';
    } else {
      return cityName;
    }
  }
}
