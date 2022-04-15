// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:satuncity/screen/OTHER/festival/festival_page.dart';
import 'package:satuncity/screen/OTHER/review/review_page.dart';
import 'package:satuncity/screen/OTHER/westher.dart';
import 'package:satuncity/screen/Food/food_page.dart';

import 'OTHER/trip_page.dart';

class Other extends StatefulWidget {
  @override
  _OtherState createState() => _OtherState();
}

class _OtherState extends State<Other> {
  // เมนูร้านอาหาร //////////////////////////////////////////////////////////////////////
  Widget iconfood() {
    return OutlineButton(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.restaurant,
            size: 60.0,
          ),
          Text("ร้านอาหาร")
        ],
      ),
      borderSide: BorderSide.none,
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => FoodPage());
        Navigator.push(context, route);
      },
    );
  }

// เมนูสภาพอากาศ //////////////////////////////////////////////////////////////////////
  Widget iconwesther() {
    return OutlineButton(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wb_sunny,
            size: 60.0,
          ),
          Text("สภาพภูมิอากาศ")
        ],
      ),
      borderSide: BorderSide.none,
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Westher());
        Navigator.push(context, route);
      },
    );
  }

// เมนูงานประจำ //////////////////////////////////////////////////////////////////////
  Widget iconannual() {
    return OutlineButton(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_florist,
            size: 60.0,
          ),
          Text("งานประจำปี")
        ],
      ),
      borderSide: BorderSide.none,
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => Festival());
        Navigator.push(context, route);
      },
    );
  }

// เมนูรีวิว //////////////////////////////////////////////////////////////////////
  Widget iconreview() {
    return OutlineButton(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.rate_review,
            size: 60.0,
          ),
          Text("รีวิวสถานที่ท่องเที่ยว")
        ],
      ),
      borderSide: BorderSide.none,
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => ReviewPage());
        Navigator.push(context, route);
      },
    );
  }

// เมนูการเดินทาง //////////////////////////////////////////////////////////////////////
  Widget icontrip() {
    return OutlineButton(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.airport_shuttle,
            size: 60.0,
          ),
          Text("การเดินทาง")
        ],
      ),
      borderSide: BorderSide.none,
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => TripPage());
        Navigator.push(context, route);
      },
    );
  }

  Widget row1() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [iconfood(), iconwesther()],
    );
  }

  Widget row2() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [iconannual(), iconreview()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            row1(),
            Padding(padding: EdgeInsets.only(bottom: 25.0)),
            row2(),
            Padding(padding: EdgeInsets.only(bottom: 25.0)),
            icontrip()
          ],
        ),
      ),
    );
  }
}
