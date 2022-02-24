import 'package:contra_care/services/translate.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:google_fonts/google_fonts.dart';

class Pills extends StatefulWidget {
  @override
  _PillsState createState() => _PillsState();
}

class _PillsState extends State<Pills> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 20, 5),
              child: Text(
                "Diabetes is a chronic disease that occurs either when the pancreas does "
                    "not produce enough insulin or when the body cannot effectively use the insulin it produces."
                    " Insulin is a hormone that regulates blood sugar. \n\n Diabetes symptoms",
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
            child: Pillsinfo1(),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Pills extends StatefulWidget {
//   @override
//   _PillsState createState() => _PillsState();
// }

// class _PillsState extends State<Pills> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Test pills'),
//       // ),
//       body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('table1').snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) return Text('loading pills');
//             return ListView.builder(
//                 itemCount: snapshot.data.size,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     child: ListTile(
//                       title: Text(
//                         snapshot.data.docs[index]['name'],
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   );
//                 });
//           }),
//     );
//   }
//

class Pillsinfo1 extends StatefulWidget {
  const Pillsinfo1({Key key}) : super(key: key);

  @override
  _Pillsinfo1State createState() => _Pillsinfo1State();
}

class _Pillsinfo1State extends State<Pillsinfo1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('table1').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(child: Center(child: CircularProgressIndicator()));
            return ListView.builder(
                itemCount: snapshot.data.size,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: NeumorphicContainer(
                            height: 50,
                            width: 400,
                            borderRadius: 150,
                            depth: 20,
                            borderColor: Colors.pinkAccent,
                            borderThickness: 1,
                            curvature: Curvature.flat,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, top: 13),
                              child: Text(snapshot.data.docs[index]['name'],
                                  // style: TextStyle(fontSize: 17),
                                  style: GoogleFonts.alikeAngular(
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 17,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.grey[700])),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}

