import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/screen/OTHER/post.dart';

class Search extends StatefulWidget {
  dynamic travelName, travelCate;
  Search({Key key, this.travelName, this.travelCate}) : super(key: key);
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingController = TextEditingController();
  dynamic searchString, result;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('travel_name').snapshots();

  // final database = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
  //  @override
  // Widget build(BuildContext context) {
//     uploadData(String name) async {

//       List<String> splitList = name.split(' ');
//       List<String> indexList = [];
//       for (var i = 0; i < splitList.length; i++) {
//         for (var j = 0; j < splitList[i].length; j++) {
//           indexList.add(splitList[i].substring(0, j).toLowerCase());
//         }
//       }
//  final database = FirebaseFirestore.instance;
//       database
//           .collection('news')
//           .add({'product': name, 'searchIndex': indexList});
//     }

//     return SafeArea(
//       child: Scaffold(
//           body: Container(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: TextField(
//                 controller: textEditingController,
//                 decoration: InputDecoration(
//                     prefixIcon: IconButton(
//                       color: Colors.black,
//                       icon: Icon(Icons.clear),
//                       iconSize: 20,
//                       onPressed: () {
//                         textEditingController.clear();
//                       },
//                     ),
//                     contentPadding: EdgeInsets.only(left: 25),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(4)),
//                     hintText: 'Search by name...'),
//               ),
//             ),
//             MaterialButton(
//               onPressed: () {
//                 uploadData(textEditingController.text);
//               },
//               color: Colors.green,
//               child: Text('Upload data'),
//             )
//           ],
//         ),
//       )),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                    controller: textEditingController,
                    decoration: InputDecoration(
                        hintText: 'Search..',
                        suffixIcon: IconButton(
                            onPressed: () {
                              textEditingController.clear();
                            },
                            icon: const Icon(Icons.clear))),
                  ),
                ),
              ),
              Expanded(child: _buildBody(context))
            ],
          ))
        ],
      )),
    );
  }

  Widget _buildBody(BuildContext context) {
    Firebase.initializeApp(); // new
    return StreamBuilder<QuerySnapshot>(
      stream: (searchString == null || searchString.trim() == '')
          ? _usersStream
          : FirebaseFirestore.instance
              .collection('travel_name')
              .where('searchIndex', arrayContains: searchString)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('we got an error ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const SizedBox(
              child: Center(
                child: Text('data'),
              ),
            );
          case ConnectionState.none:
            return const Text('no data');

          case ConnectionState.done:
            return const Text('we are done');

          default:
            return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
              return FlatButton(
                  onPressed: () {
                    print('66666666666666666666666' + document['name']);
                    result = document['name'];
                    print('ddddddddddddddddddddddddddddddddd' + result);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Post(
                            travelName: result,picUrl:document['pic'] ,
                          ),
                        ));
                  },
                  child: Row(
                    children: [
                      Text(document['name']),
                    ],
                  ));

              // ListTile(
              //   title: Text(document['product']),
              // );
            }).toList());
        }
      },
    );
  }
}