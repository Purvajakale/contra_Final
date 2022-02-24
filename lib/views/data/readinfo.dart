import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class ReadInfoPage extends StatefulWidget {
  const ReadInfoPage({Key key}) : super(key: key);

  @override
  _ReadInfoPageState createState() => _ReadInfoPageState();
}

class _ReadInfoPageState extends State<ReadInfoPage> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('readmore')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else {
                return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data.size,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Container(
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.pinkAccent, width: 1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 20, right: 15),
                                        child: Text(
                                          snapshot.data.docs[index]['title'],
                                          style: GoogleFonts.solway(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800]),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 15, top: 10, bottom: 10),
                                        child: ReadMoreText(
                                          snapshot.data.docs[index]['desc'],
                                          trimLines: 2,
                                          style: GoogleFonts.solway(
                                              fontSize: 17, color: Colors.grey[800]),
                                          colorClickableText: Colors.grey[400],
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'Show more',
                                          trimExpandedText: ' show less',
                                          textAlign: TextAlign.justify,
                                        ),
                                      )
                                    ],
                                  ),
                                ),SizedBox(height: 5,),
                              ],
                            )),
                      );
                    },
                  ),
                );
              }
            }));
  }
}