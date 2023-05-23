import 'package:flutter/material.dart';

class StationTwo extends StatelessWidget {
  const StationTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station 2 ...'),
      ),
      body:
          const Center(child: Text("Hierhin kommt der Inhalt für Station 2.")),
    );
  }
}
