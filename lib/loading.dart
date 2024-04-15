import 'package:flutter/material.dart';
import 'package:sky_sense/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String temp1;
  late String humidity1;
  late String location1="Stockholm";
  late String airSpeed1;
  late String description1;
  late String state1;
  late String icon1;
  void startApp(String city) async {
    worker instance = worker(location: city);
    await instance.getData();
    temp1 = instance.temp;
    humidity1 = instance.humidity;
    location1 = instance.location;
    airSpeed1 = instance.airSpeed;
    description1 = instance.description;
    state1 = instance.state;
    icon1 = instance.icon;
    Future.delayed(const Duration(seconds: 03),(){
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "tempValue": temp1,
        "humidityValue": humidity1,
        "locationValue": location1,
        "airSpeedValue": airSpeed1,
        "descriptionValue": description1,
        "stateValue": state1,
        "iconValue":icon1,
      });
    });

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? search =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if(search?.isNotEmpty ?? false){
      location1=search?['searchText'];
    }
    startApp(location1);
    return Scaffold(
      backgroundColor:  Colors.blue,
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "lib/images/skySenseLogo.png",
            height: 190,
            width: 190,
          ),
          const SizedBox(height: 40),
          const Text(
            "ꌗꀘꌩ ꌗꍟꈤꌗꍟ",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          const SpinKitWave(
            color: Colors.white,
            size: 50.0,
          ),
        ],
      ),
    ));
  }
}
