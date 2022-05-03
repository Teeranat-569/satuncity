import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:satuncity/drawer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          // automaticallyImplyLeading: false,
          title: Text(
            "รีวิวสถานที่ท่องเที่ยว",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'Yaldevi',
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('comment').orderBy('timeago', descending: true).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data.docs;
                return ListView(
                  children: documents
                      .map((doc) => SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10,left: 20),
                                    child: Text(
                                      "@ " + doc['travelName'],
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  if (doc['pic'] != null) ...[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                height: 100,
                                                width: 100,
                                                child: Image(
                                                  image: NetworkImage(
                                                    doc['pic'],
                                                  ),
                                                  fit: BoxFit.contain,
                                                )),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width*0.63,
                                                    child: Text(
                                                        doc[
                                                            'travelName'], //username
                                                        style: TextStyle(
                                                            fontSize: 16.5,
                                                            fontWeight:
                                                                FontWeight.bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          SmoothStarRating(
                                            borderColor: Colors.yellow.shade700,
                                            color: Colors.yellow.shade700,
                                            rating: 2,
                                            isReadOnly: false,
                                            size: 30,
                                            filledIconData: Icons.star,
                                            halfFilledIconData: Icons.star_half,
                                            defaultIconData: Icons.star_border,
                                            starCount: 1,
                                            spacing: 2.0,
                                            onRated: (value) {},
                                          ),
                                          Text(
                                            doc['rate'].toString(),
                                          ),
                                          doc['comment'] != null
                                              ? Text(":" + doc['comment'],
                                                  style: TextStyle())
                                              : Text("Some Descritiption",
                                                  style: TextStyle())
                                        ],
                                      ),
                                    )
                                  ] else if (doc['pic'] == null) ...[
                                    Container(
                                        height: 400,
                                        width: 400,
                                        child: Image(
                                          image:
                                              AssetImage("assets/images/1.jpg"),
                                          fit: BoxFit.contain,
                                        ))
                                  ],
                                  Divider(
                                    color: Colors.black,
                                    height: 10,
                                  ),
                                ]),
                          ))
                      .toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
