import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sky_sense/worker/worker.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:sky_sense/loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print("Created init state");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("widget destroyed");
  }

  @override
  Widget build(BuildContext context) {
    //accessing the map data coming from route loading
    Map<String, dynamic>? info =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    String finalDescription = 'N/A';
    String finalLocation = 'N/A';
    String finalTemp = 'N/A';
    String finalAirSpeed = 'N/A';
    String finalHumidity = 'N/A';
    String finalIcon = '01d';
    late String fLocation;

    if (info != null) {
      finalDescription = info['descriptionValue'] ?? 'N/A';
      finalLocation = info['locationValue'] ?? 'N/A';
      finalTemp = info['tempValue'] ?? 'N/A';
      finalAirSpeed = info['airSpeedValue'] ?? 'N/A';
      finalHumidity = info['humidityValue'] ?? 'N/A';
      finalIcon = info['iconValue'] ?? '01d';
      fLocation=finalLocation.toUpperCase();
      // Your widget tree continues here, using the safe values obtained
    } else {
      // Handle the case when info is null
      return const Scaffold(
        body: Center(
          child: SpinKitWave(
            color: Colors.blue, // Customize the color if needed
            size: 50.0, // Customize the size if needed
          ),
        ),
      );
    }


    var cityName = [
      "Bali",
      "Paris",
      "Copenhagen",
      "Stockholm",
      "Oslo",
      "Rome",
      "Barcelona",
      "Amsterdam",
      "Berlin",
      "Venice",
      "Prague",
      "Vienna",
      "Madrid",
      "Edinburgh",
      "Liverpool",
    ];
    final random = Random();
    String city = cityName[random.nextInt(cityName.length)];

    void _performSearch(String searchText) {
      if (searchText.trim().isEmpty) {
        print("Blank space");
      } else {
        print(searchText);
        Navigator.pushReplacementNamed(
          context, "/loading", arguments: {
          "searchText": searchText,
        },
        );
      }
    }
    String capitalize(String s) {
      if (s.isEmpty) return s;
      return s.substring(0, 1).toUpperCase() + s.substring(1);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: GradientAppBar(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade500
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Colors.blue.shade900, Colors.blue.shade200])),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "")==""){
                            print("Blank space");
                          }else {
                            print(searchController.text);
                            Navigator.pushReplacementNamed(
                                context, "/loading", arguments: {
                              "searchText": searchController.text,
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                          child: Icon(
                            Icons.search,
                            color: Colors.lightBlue.shade300,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onSubmitted: (value) {
                            _performSearch(value);
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Search $city"),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        padding: const EdgeInsets.all(26),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(capitalize(finalDescription),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text("$fLocation",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.red),),],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.network("https://openweathermap.org/img/wn/$finalIcon@2x.png"),
                              ],
                            )

                          ],
                        )
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(WeatherIcons.thermometer),
                            SizedBox(height: 25,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$finalTemp°", style: TextStyle(fontSize: 90, fontWeight: FontWeight.bold),),
                                Text("C",style: TextStyle(fontWeight: FontWeight.bold,fontSize:70 ),)
                              ],
                            )
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.fromLTRB(25, 0, 10, 0),
                        padding: const EdgeInsets.all(26),
                        child:  Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.cloudy_windy),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text(finalAirSpeed ,style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                          const Text("Km/hr",style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text( finalHumidity,style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                            const Text("Percent",style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                    padding: const EdgeInsets.all(42),
                    child:  const Text("ꌗꀘꌩ ꌗꍟꈤꌗꍟ",style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.white),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
