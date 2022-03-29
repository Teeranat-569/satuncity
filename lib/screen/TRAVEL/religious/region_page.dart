// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'region_data.dart';

class RegionPage extends StatefulWidget {
  dynamic travelCate;
  RegionPage({Key key, this.travelCate}) : super(key: key);
  @override
  _RegionPageState createState() => _RegionPageState();
}

class _RegionPageState extends State<RegionPage> {
  dynamic travelName, docID, travel_catep;
  dynamic travelCate;
  dynamic url;
  bool loadStatus = true;

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('travel_region')
      .where('travelCate')
      .snapshots();
  
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('travel_region')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          docID = doc.id;
          travel_catep = doc["travelCate"];
        });

        print(doc["travelCate"]);
        print(docID);

        // if (widget.otopName == doc["otop_name"]) {
          print('dddddddddddddddeeeeeeeeeddddddd${doc.id}');
        //   collection
        //       .collection('otop_store')
        //       .doc(doc
        //           .id) // <-- Doc ID where data should be updated.
        //       .update({
        //     'otop_name': textEditingController.text,
        //     // 'travel_map': t,
        //   });
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return showData();
  }

  StreamBuilder<QuerySnapshot<Object>> showData() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          loadStatus = true;

          return Scaffold(
            body: Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }

        loadStatus = false;
        // print(object)
        return Scaffold(
          appBar: AppBar(
            title: Text('${widget.travelCate}'),
          ),
          // ignore: avoid_unnecessary_containers
          body: SafeArea(
              child: Stack(
            children: [
              loadStatus
                  ? Center(child: CircularProgressIndicator())
                  : show(snapshot, context),
            ],
          )),
        );
      },
    );
  }

  Container show(
      AsyncSnapshot<QuerySnapshot<Object>> snapshot, BuildContext context) {
    return Container(
      child: ListView(
        children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          data["docid"] = document.id;
          travelName = data['travelName'];
          travelCate = data['travelCate'];
          url = data['pic'].toString();

          // ignore: avoid_print
          print('4444444444444444444444444 ${data["docid"]}');
          print('4444444444444444444444444 ${data["travelCate"]}');
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey.shade200,
              ),
              width: MediaQuery.of(context).size.width,
              // ignore: deprecated_member_use
              child: Column(
                children: [
                  if (travelCate == widget.travelCate)
                    InkWell(
                      child: Container(
                          height: 120,
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage("$url"))),
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Color.fromARGB(99, 0, 0, 0),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  data['travelName'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (BuildContext context) => RegionData(
                                  travelName: data['travelName'],
                                  travelCate: data['travelCate'],
                                ));
                        Navigator.push(context, route);
                      },
                    )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
