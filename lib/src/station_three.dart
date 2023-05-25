import 'package:flutter/material.dart';

class StationThree extends StatelessWidget {
  const StationThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station 3 ...'),
      ),
      body:
          const Center(child: Text("Hierhin kommt der Inhalt für Station 3.")),
    );
  }
}
