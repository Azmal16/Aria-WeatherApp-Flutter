import 'package:flutter/material.dart';
import 'package:aria/utilities/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff060E2E),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: kBoxDecorationStyle.copyWith(
                    color: Color(0xffFAB03C),
                  ),
                  child: Text(
                    'Get Weather',
                    style: GoogleFonts.roboto(textStyle: kButtonTextStyle),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
