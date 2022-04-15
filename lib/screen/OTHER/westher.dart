import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Westher extends StatefulWidget {
  @override
  _WestherState createState() => _WestherState();
}

class _WestherState extends State<Westher> {
  var urlapi = Uri.parse(
      "http://api.openweathermap.org/data/2.5/weather?lat=6.624527948706493&lon=100.06914368608301&appid=1899a0e4a716966b84bc68bef8097d06");

  @override
  void initState() {
    super.initState();
    getapi();
  }

  dynamic ss;

  void getapi() async {
    var response = await http.post(urlapi);
    var dataapi = json.decode(response.body);
    Map asd = Map.from(dataapi);
    ss = asd['main']['temp'] - 273.15;
    setState(() {});
    print(ss.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สภาพภูมิอากาศ"),
      ),
      body: Center(
        child: ss == null
            ? CircularProgressIndicator()
            : Text(
                'จ.สตูล \n  ${ss.toInt()} ํ',
                style: TextStyle(fontSize: 36),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
