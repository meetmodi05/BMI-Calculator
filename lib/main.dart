import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bmi_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Colors.cyan,
          titleTextStyle: GoogleFonts.ubuntu(fontSize: 25.0,)

        )
      ),
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        brightness: Brightness.light,
      ),
      home: MyBMIForm(),
    );
  }
}
