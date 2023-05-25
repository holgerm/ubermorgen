import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state_model.dart';
import 'station_one.dart';
import 'station_three.dart';
import 'station_two.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dein Ort im Übermorgen'),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(width: 100),
          Consumer<StateModel>(builder: (context, value, child) {
            bool? done = value.points['station1']!['done'];
            return Text("Thema 1: $done", textAlign: TextAlign.center);
          }),
          Consumer<StateModel>(builder: (context, value, child) {
            bool? done = value.points['station2']!['done'];
            return Text("Thema 2: $done", textAlign: TextAlign.center);
          }),
          Consumer<StateModel>(builder: (context, value, child) {
            bool? done = value.points['station3']!['done'];
            return Text("Thema 3: $done", textAlign: TextAlign.center);
          }),
          const SizedBox(width: 100),
        ],
      )),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Übersicht'),
            ),
            ListTile(
              title: const Text('Station 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                //Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StationOne()));
              },
            ),
            ListTile(
              title: const Text('Station 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StationTwo()));
              },
            ),
            ListTile(
              title: const Text('Station 3'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StationThree()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
