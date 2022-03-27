import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'post.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Text(
            "รีวิวสถานที่ท่องเที่ยว",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'Yaldevi',
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.post_add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Post(),
                    ));
              },
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('comment').snapshots(),
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
                                  // ListTile(
                                  //   leading: doc['pic'] == null //profile
                                  //       ? CircleAvatar(
                                  //           radius: 16.6,
                                  //           backgroundColor: Colors.white24,
                                  //         )
                                  //       : CircleAvatar(
                                  //           radius: 16.6,
                                  //           backgroundImage:
                                  //               AssetImage('images/user.png')),
                                  //   title: Text(doc['travelName'],
                                  //       style: TextStyle(
                                  //         fontSize: 16.5,
                                  //       )),
                                  //   // subtitle: doc['comment'] != null
                                  //   //     ? Text(
                                  //   //         doc['comment'],
                                  //   //         style: TextStyle(
                                  //   //           color: Colors.white,
                                  //   //           fontSize: 12.5,
                                  //   //         ),
                                  //   //       )
                                  //   //     : Text("Some Title",
                                  //   //         style: TextStyle(
                                  //   //           color: Colors.white,
                                  //   //         )),
                                  // ),
                                  ListTile(
                                      title: Text(
                                        "@ " + doc['travelName'],
                                        style: TextStyle(),
                                      ),
                                     ),
                                  if (doc['pic'] != null) ...[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          //
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
                                                  Text(
                                                      doc[
                                                          'travelName'], //username
                                                      style: TextStyle(
                                                          fontSize: 16.5,
                                                          fontWeight:
                                                              FontWeight.bold)),
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

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return '${diff.inDays} day(s) ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour(s) ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }
}
