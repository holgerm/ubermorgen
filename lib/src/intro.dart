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
      body: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Consumer<StateModel>(
              builder: (context, value, child) {
                bool done = value.points[S.keyStation1]![S.keyDone]!;
                return StationField(
                    done, "Ökonomie - Upcycling", "oekonomie.png");
              },
            ),
            Consumer<StateModel>(
              builder: (context, value, child) {
                bool done = value.points[S.keyStation2]![S.keyDone]!;
                return StationField(
                    done, "Ökologie - Mobilität", "oekologie.png");
              },
            ),
            Consumer<StateModel>(
              builder: (context, value, child) {
                bool done = value.points[S.keyStation3]![S.keyDone]!;
                return StationField(
                    done, "Soziales - Fairer Handel", "soziales.png");
              },
            ),
          ],
        ),
      ),
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

class StationField extends StatelessWidget {
  final bool done;
  final String title;
  final String iconname;

  const StationField(this.done, this.title, this.iconname, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        const SizedBox(height: 8),
        ImageIcon(AssetImage('icons/$iconname'), size: 75),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {
            if (title == "Ökonomie - Upcycling") {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const StationOne()));
            }
            if (title == "Ökologie - Mobilität") {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const StationTwo()));
            }
            if (title == "Soziales - Fairer Handel") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const StationThree()));
            }
          },
          child: done ? const Text("Ansehen") : const Text("Starten"),
        )
      ],
    );
  }
}
