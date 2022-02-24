import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqPage2 extends StatefulWidget {
  //const FaqPage2({ Key? key }) : super(key: key);

  @override
  _FaqPage2State createState() => _FaqPage2State();
}

class _FaqPage2State extends State<FaqPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 20, 10),
              child: Text(
                "Heart Diseases",
                style: GoogleFonts.alikeAngular(
                  // fontStyle: FontStyle.italic,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
            ),
          ),
          SizedBox(height: 18),
          Expanded(
            child: faqs1(),
          ),
        ],
      ),
    );
  }
}

class faqs1 extends StatefulWidget {
  const faqs1({Key key}) : super(key: key);

  @override
  _faqs1State createState() => _faqs1State();
}

class _faqs1State extends State<faqs1> {
  UniqueKey keyTile;
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('faqs2').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else {
              return Container(
                child: ListView.builder(
                    itemCount: snapshot.data.size,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: Colors.pinkAccent,
                                width: 1.0,
                              ),
                            ),
                            shadowColor: Color(0xffFFE3ED),
                            elevation: 0,
                            child: ExpansionTile(
                              key: keyTile,
                              backgroundColor: Colors.transparent,
                              initiallyExpanded: isExpanded,
                              childrenPadding:
                              EdgeInsets.all(22).copyWith(top: 0),
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.docs[index]['ques'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              children: [
                                Text(
                                  snapshot.data.docs[index]['ans'],
                                textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(bottom: 12),
                      );
                    }),
              );
            }
          }),
    );
  }
}