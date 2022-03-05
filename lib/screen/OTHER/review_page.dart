import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'comment.dart';
import 'post.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // bottomNavigationBar: BottomNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          "Platform",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32.96,
            fontWeight: FontWeight.w500,
            fontFamily: 'Yaldevi',
          ),
        ),
        actions: [  IconButton(
                          icon: Icon(
                            Icons.post_add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                             MaterialPageRoute(
                              builder: (context) =>
                                 Post(),
                             ));
                          },

                        )],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return ListView(
              children: documents.map((doc) => SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: doc['pic'] == null ?
                        CircleAvatar(
                          radius: 16.6,
                          backgroundColor: Colors.white24,
                        ) :
                        CircleAvatar(
                            radius: 16.6,
                            backgroundImage: NetworkImage(
                                doc['pic']
                            )
                        ),
                        title: Text(
                            doc['user_name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.5,
                            )
                        ),
                        subtitle: doc['title'] !=null ?
                        Text(
                          doc['title'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.5,
                          ),
                        ) :
                        Text(
                            "Some Title",
                            style: TextStyle(
                              color: Colors.white,
                            )
                        ),
                      ),
                      if(doc['photo'] != null) ... [
                        Container(
                          height: 400,
                          width: 400,
                          child: Image(
                            image: NetworkImage(
                              doc['photo'],
                            ),
                            fit: BoxFit.contain,
                          )
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.mode_comment_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                             MaterialPageRoute(
                              builder: (context) =>
                                  CommentSection(),
                             ));
                          },

                        )

                      ] else if(doc['photo'] == null) ...[
                        Container(
                          height: 400,
                          width: 400,
                          child: Image(
                            image: AssetImage(
                              "assets/images/1.jpg"
                            ),
                            fit: BoxFit.contain,
                          )
                        )
                      ],
                      ListTile(
                          leading: Padding(
                            padding: EdgeInsets.only(bottom: 13.5 ),
                            child: Text( "@ " +
                                doc['user_name'],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          subtitle: Padding(
                              padding: EdgeInsets.only(bottom: 13.5),
                              child: doc['title'] != null ?
                              Text( ":" +
                                  doc['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                  )
                              ) :
                              Text(
                                  "Some Descritiption",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )
                              )
                          )
                      ),
                    ]
                ),
              )).toList(),
            );
          } else {
            return CircularProgressIndicator();
          }
        }
      )
    );
  }
}