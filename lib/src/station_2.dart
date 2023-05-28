import 'package:flutter/material.dart';

import 'ubermorgen.dart' show S;

class StationTwo extends StatelessWidget {
  const StationTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.station2Title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(25.0),
            child: const Text(S.station2Task),
          ),
          const Station2Task1(),
        ],
      )),
    );
  }
}

class Station2Task1 extends StatelessWidget {
  const Station2Task1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
