import 'package:flutter/material.dart';
import 'package:aria/screens/loading_screen.dart';

//last edited on video 13
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: LoadingScreen(),
    );
  }
}
