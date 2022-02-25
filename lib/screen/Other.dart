import 'package:flutter/material.dart';
import 'package:satuncity/screen/OTHER/annual.dart';
import 'package:satuncity/screen/OTHER/food.dart';
import 'package:satuncity/screen/OTHER/review.dart';
import 'package:satuncity/screen/OTHER/westher.dart';
import 'package:satuncity/screen/food.dart';

class Other extends StatefulWidget {
  @override
  _OtherState createState() => _OtherState();
}

class _OtherState extends State<Other> {
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
            MaterialPageRoute(builder: (BuildContext context) => Food2());
        Navigator.push(context, route);
      },
    );
  }

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
            MaterialPageRoute(builder: (BuildContext context) => Annual());
        Navigator.push(context, route);
      },
    );
  }

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
            MaterialPageRoute(builder: (BuildContext context) => Review());
        Navigator.push(context, route);
      },
    );
  }

  Widget row2() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [iconannual(), iconreview()],
    );
  }

  Widget row1() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [iconfood(), iconwesther()],
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
            row2()
          ],
        ),
      ),
    );
  }
}
