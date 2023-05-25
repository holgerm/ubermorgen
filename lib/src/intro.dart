import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ubermorgen.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(S.introTitle),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(width: 100),
          Consumer<StateModel>(builder: (context, value, child) {
            bool? done = value.points[S.keyStation1]![S.keyDone];
            return Text("Thema 1: $done", textAlign: TextAlign.center);
          }),
          Consumer<StateModel>(builder: (context, value, child) {
            bool? done = value.points[S.keyStation2]![S.keyDone];
            return Text("Thema 2: $done", textAlign: TextAlign.center);
          }),
          Consumer<StateModel>(builder: (context, value, child) {
            bool? done = value.points[S.keyStation3]![S.keyDone];
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StationOne()));
              },
            ),
            ListTile(
              title: const Text('Station 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StationTwo()));
              },
            ),
            ListTile(
              title: const Text('Station 3'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StationThree()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
