import 'package:flutter/material.dart';
import 'package:sky_sense/home.dart';
import 'package:sky_sense/location.dart';
import 'package:sky_sense/loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => const Loading(),
      "/home": (context) => Home(),
      "/loading": (context) => const Loading(),
    },
  ));
}
