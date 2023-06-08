import 'dart:async';

import 'package:flutter/material.dart';

import 'ubermorgen.dart' show S;

class StationTwo extends StatelessWidget {
  const StationTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(S.station2Title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(25.0),
              child: const Text(
                S.station2Task,
                textAlign: TextAlign.center,
              ),
            ),
            const Station2Task1(),
          ],
        )),
      ),
    );
  }
}

class Station2Task1 extends StatelessWidget {
  const Station2Task1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      child: const Column(
        children: [
          CountDown(),
          ResultArea(),
        ],
      ),
    );
  }
}

class ResultArea extends StatefulWidget {
  const ResultArea({super.key});

  @override
  State<StatefulWidget> createState() => _ResultAreaState();
}

class _ResultAreaState extends State<ResultArea> {
  double _curSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _curSliderValue,
      max: 20,
      divisions: 20,
      label: _curSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _curSliderValue = value;
        });
      },
    );
  }
}

class CountDown extends StatefulWidget {
  const CountDown({super.key});

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  int timeLeft = 120;
  bool started = false;
  late Timer currentTimer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(timeLeft.toString()),
        FilledButton(
          onPressed: started ? null : _startTimer,
          child: const Text('Start'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    currentTimer.cancel();
  }

  void _startTimer() {
    started = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTimer = timer;
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
        }
      });
    });
  }
}
