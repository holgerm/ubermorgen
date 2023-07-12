import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: S.appTitle,
      home: const Intro(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch:
            L.getMaterialColor(const Color.fromARGB(255, 0, 61, 119)),
        sliderTheme: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
        ),
      ),
    );
  }
}
