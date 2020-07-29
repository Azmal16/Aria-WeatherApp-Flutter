import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kMessageTextStyle = TextStyle(
  fontSize: 33,
  color: Color(0xffADAFB7),
  fontStyle: FontStyle.italic,
);

const kCityNameTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 30.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 23.0,
  color: Color(0xff060E2E),
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 20.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15.0),
    ),
    borderSide: BorderSide.none,
  ),
);

const kBoxDecorationStyle = BoxDecoration(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(15.0),
    topRight: Radius.circular(15.0),
    bottomLeft: Radius.circular(15.0),
    bottomRight: Radius.circular(15.0),
  ),
  color: Color(0xff141A3B),
);

const kGridInfoTextStyle = TextStyle(
  fontSize: 60,
  color: Colors.white,
  fontFamily: 'Baloo Chettan 2',
  // fontWeight: FontWeight.bold,
);

const kGridTitleTextStyle = TextStyle(
  fontSize: 15,
  color: Color(0xffADAFB7),
);

const kTempTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 95,
);

const kWeatherDescriptionTextStyle = TextStyle(
  color: Color(0xffADAFB7),
  fontSize: 18,
);
