import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contra_care/services/admin_faqs_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class UserQuery extends StatefulWidget {
  @override
  _UserQueryState createState() => _UserQueryState();
}

class _UserQueryState extends State<UserQuery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Center(child: Text('UserQueries')),
        actions: [
          RaisedButton(
            child: TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FaqUpdate())),
                child: Text(
                  'Update in FAQs',
                  style: TextStyle(color: Colors.white,fontSize: 18),
                )),
          )
        ],
        backgroundColor: Color(0xffF5637F),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('query').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            return ListView.builder(
                itemCount: snapshot.data.size,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: Color(0xffF5637F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Name:  ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${snapshot.data.docs[index]['name']}',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   height: 8,
                                // ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Query:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  '${snapshot.data.docs[index]['desc']}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }
}