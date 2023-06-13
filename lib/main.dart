import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/ubermorgen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => StateModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: S.appTitle,
      home: const Intro(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        sliderTheme: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),
      ),
    );
  }
}
