import 'package:flutter/material.dart';
import 'ubermorgen.dart' show S;

class StationThree extends StatelessWidget {
  const StationThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.station3Title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(25.0),
            child: const Text(S.station3Task),
          ),
          const Station3Task1(),
        ],
      )),
    );
  }
}

class Station3Task1 extends StatelessWidget {
  const Station3Task1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
