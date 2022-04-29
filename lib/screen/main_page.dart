// ignore_for_file: avoid_types_as_parameter_names, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatefulWidget {
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _index = 0;
  int _dataLength = 1;
  int _dataLength2 = 1;

  final CarouselController _controller = CarouselController();
  List<String> imgList = [];
  @override
  void initState() {
    getSliderImageFromDb();
    getSliderImageFromDb2();

    super.initState();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getSliderImageFromDb() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _fireStore.collection('travel').get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getSliderImageFromDb2() async {
    var _fireStore2 = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot2 =
        await _fireStore2.collection('travel_waterfall').get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot2.docs.length;
      });
    }
    return snapshot2.docs;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            // height: 550,
            // color: Colors.white,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            travelSlider(),
            waterfallSlider(),
          ],
        )),
      ),
    );
  }

  Column travelSlider() {
    return Column(
      children: [
        if (_dataLength != 0)
          FutureBuilder(
            future: getSliderImageFromDb(),
            builder: (_,
                AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                    snapShot) {
              if (snapShot.data == null) {
                return const Center(
                  child: const CircularProgressIndicator(),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: CarouselSlider.builder(
                      itemCount: snapShot.data.length,
                      itemBuilder: (BuildContext context, index, int) {
                        DocumentSnapshot<Map<String, dynamic>> sliderImage =
                            snapShot.data[index];
                        var getImage = sliderImage.data();

                        // snapShot.data.docs.map((DocumentSnapshot document) {
                        // Map<String, dynamic> data =
                        //     document.data() as Map<String, dynamic>;
                        return Container(
                          height: 1000,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                NetworkImage(getImage['pic']))),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 50,
                                        color: Color.fromARGB(99, 0, 0, 0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            getImage['travelName'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                    // getImage['pic'] == null
                                    //     ? CircularProgressIndicator()
                                    //     : Image.network(
                                    //         getImage['pic'],
                                    //         fit: BoxFit.fill,
                                    //       )
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                          autoPlayCurve: Curves.slowMiddle,
                          autoPlayInterval: Duration(seconds: 6),
                          viewportFraction: 1,
                          initialPage: 0,
                          autoPlay: true,
                          height: MediaQuery.of(context).size.height * 0.36,
                          onPageChanged: (int i, carouselPageChangedReason) {
                            setState(() {
                              _index = i;
                            });
                          })),
                );
              }
            },
          ),
      ],
    );
  }

  Column waterfallSlider() {
    return Column(
      children: [
        if (_dataLength2 != 0)
          FutureBuilder(
            future: getSliderImageFromDb2(),
            builder: (_,
                AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                    snapShot2) {
              if (snapShot2.data == null) {
                return const Center(
                  child: const CircularProgressIndicator(),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: CarouselSlider.builder(
                      itemCount: snapShot2.data.length,
                      itemBuilder: (BuildContext context, index2, int) {
                        DocumentSnapshot<Map<String, dynamic>> sliderImage2 =
                            snapShot2.data[index2];
                        var getImage2 = sliderImage2.data();

                        // snapShot.data.docs.map((DocumentSnapshot document) {
                        // Map<String, dynamic> data =
                        //     document.data() as Map<String, dynamic>;
                        return Container(
                          height: 1000,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                getImage2['pic']))),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 50,
                                        color: Color.fromARGB(99, 0, 0, 0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            getImage2['travelName'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                    // getImage['pic'] == null
                                    //     ? CircularProgressIndicator()
                                    //     : Image.network(
                                    //         getImage['pic'],
                                    //         fit: BoxFit.fill,
                                    //       )
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                          autoPlayCurve: Curves.slowMiddle,
                          reverse: true,
                          autoPlayInterval: Duration(seconds: 12),
                          viewportFraction: 1,
                          initialPage: 0,
                          autoPlay: true,
                          height: MediaQuery.of(context).size.height * 0.36,
                          onPageChanged: (int i, carouselPageChangedReason) {
                            setState(() {
                              _index = i;
                            });
                          })),
                );
              }
            },
          ),
      ],
    );
  }
}
