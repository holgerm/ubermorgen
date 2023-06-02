import 'package:flutter/material.dart';
import 'ubermorgen.dart' show S;

class StationOne extends StatelessWidget {
  const StationOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.station1Title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(25.0),
            child: const Text(S.station1Task),
          ),
          const Station1Task1(),
        ],
      )),
    );
  }
}

class Station1Task1 extends StatelessWidget {
  const Station1Task1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(25.0), child: const Placeholder());
  }
}
