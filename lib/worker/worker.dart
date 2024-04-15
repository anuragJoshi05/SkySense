import 'package:http/http.dart' as http;
import 'dart:convert';

class worker {
  late String temp;
  late String humidity;
  late String location;
  late String airSpeed;
  late String description;
  late String state;
  late String icon;

  worker({required this.location});

  Future<void> getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=4c10b56a6a4f1f4f74ce5d582a2f69db"));
    //JSON decoding
    Map<String, dynamic> data = jsonDecode(response.body);
    //going to main in our API
    Map<String, dynamic> mainData = data['main'];
    double tempFormatted = (mainData['temp'] - 273.15);
    int getTemp = tempFormatted.round();
    int getHumidity = mainData['humidity'];
    //going to wind in
    Map<String, dynamic> windData = data['wind'];
    double speedTemp = windData['speed'] * 3.6;
    int getSpeed = speedTemp.round();
    //going to weather in our API
    List<dynamic> weatherData = data['weather'];
    Map<String, dynamic> xWeatherData = weatherData[0];
    String getState = xWeatherData['main'];
    String getDescription = xWeatherData['description'];
    String getIcon = xWeatherData['icon'];

    //Assigning values
    temp = getTemp.toString();
    humidity = getHumidity.toString();
    airSpeed = getSpeed.toString();
    description = getDescription;
    state = getState;
    icon = getIcon;
  }
}
