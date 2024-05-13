import 'package:flutter/material.dart';
//newline
class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/home");
                },
                icon: const Icon(Icons.add_to_home_screen_sharp),
                label: const Text("GO TO HOME")),
            FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/loading");
                },
                icon: const Icon(Icons.add_to_home_screen_sharp),
                label: const Text("GO TO LOADING"))
          ],
        ),
      ),
    );
  }
}
