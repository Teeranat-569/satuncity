import 'package:flutter/material.dart';
import 'package:satuncity/screen/admin/addTravel.dart';
import 'package:satuncity/screen/admin/add_otop.dart';
import 'package:satuncity/screen/admin/add_restaurant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../TRAVEL/sea.dart';
import '../home.dart';

class Admin extends StatefulWidget {
  const Admin({Key key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('เพิ่มข้อมูลสถานที่'), leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
             MaterialPageRoute route = MaterialPageRoute(
                                    builder: (BuildContext context) => Home(
                                         
                                        ));
          },),),
        body: Column(
          children: [
            cate("สถานที่ท่องเที่ยว", AddTravel(), "images/sea1.jpg"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            cate("สินค้า OTOP", AddOtop(), "images/sea1.jpg"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            cate("ร้านอาหาร", Addrestaurant(), "images/sea1.jpg"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
            cate("งานประจำปี", Sea(), "images/sea1.jpg"),
            Padding(padding: EdgeInsets.only(bottom: 12.0)),
          ],
        ),
      ),
    );
  }

  Widget cate(var text, Widget routeName, String pathIMG) {
    //ทะเล
    return InkWell(
      child: Container(
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/hinngam.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(99, 0, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )),
      onTap: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) => routeName);
        Navigator.push(context, route);
      },
    );
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
