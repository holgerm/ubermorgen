import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class L {
  static const heightOfTaskDescription = 22;
  static const heightOfFooter = 20;
  static const heightOfContent =
      100 - (heightOfTaskDescription + heightOfFooter);

  static const fontSize = 20.0;
  static const fontSizeSubTitle = 28.0;
  static const fontSizeHeader = 35.0;

  static const s1color = Color.fromARGB(255, 247, 148, 29);
  static const s1colorCompleted = Color.fromARGB(255, 247, 183, 105);
  static const s2color = Color.fromARGB(255, 141, 198, 63);
  static const s2colorCompleted = Color.fromARGB(255, 158, 197, 102);
  static const s3color = Color.fromARGB(255, 0, 174, 239);
  static const s3colorCompleted = Color.fromARGB(255, 62, 188, 233);

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }

  // AUDIO:
  // static final AudioPlayer playerWin = AudioPlayer();

  // static Future<void> playWin() async {
  //   await playerWin.play(AssetSource("audio/win.mp3"));
  // }
}
