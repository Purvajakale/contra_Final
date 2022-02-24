import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class Table2 extends StatefulWidget {
  @override
  _Table2State createState() => _Table2State();
}

class _Table2State extends State<Table2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 20, 5),
              child: Text(
                "Heart disease is synonymous with cardiac disease but not with cardiovascular "
                    "disease which is any disease of the heart or blood vessels. \n\n Heart Diseases symptoms",
                textAlign: TextAlign.justify,
                style: GoogleFonts.alikeAngular(
                  // fontStyle: FontStyle.italic,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: Pill2info(),
          ),
        ],
      ),
    );
  }
}

class Pill2info extends StatefulWidget {
  const Pill2info({Key key}) : super(key: key);

  @override
  _Pill2infoState createState() => _Pill2infoState();
}

class _Pill2infoState extends State<Pill2info> {
  Color color = Color(0xfff0f0f0);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('table2').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            return ListView.builder(
                itemCount: snapshot.data.size,
                itemBuilder: (context, index) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: NeumorphicContainer(
                        height: 50,
                        width: 60,
                        borderRadius: 150,
                        depth: 20,
                        primaryColor: color,
                        borderColor: Colors.pinkAccent,
                        borderThickness: 1,
                        curvature: Curvature.flat,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 13),
                          child: Text(snapshot.data.docs[index]['name'],
                              style: GoogleFonts.alikeAngular(
                                // fontStyle: FontStyle.italic,
                                  fontSize: 17,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.grey[700])),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
