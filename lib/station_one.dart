import 'package:flutter/material.dart';

class StationOne extends StatelessWidget {
  const StationOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station 1 ...'),
      ),
      body:
          const Center(child: Text("Hierhin kommt der Inhalt für Station 1.")),
    );
  }
}
