import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Faq1Update extends StatefulWidget {
  const Faq1Update({ Key key }) : super(key: key);

  @override
  _Faq1UpdateState createState() => _Faq1UpdateState();
}

class _Faq1UpdateState extends State<Faq1Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 20, 5),
              child: Text("Daibetes",
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
  String id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String ques,ans;

  Card buildItem(DocumentSnapshot doc) {
    return Card( shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),side: BorderSide(
      color: Colors.pinkAccent,
      width: 0.8,
    ),
    ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'question: ${doc['ques']}',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15),
            ),SizedBox(height: 5),
            Text(
              'answer: ${doc['ans']}',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(width: 8),
                Container(
                    child: IconButton(
                      onPressed: () => alertbox(doc),
                      icon: Icon(Icons.delete),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildTextFormField() {
    return Card(color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.pinkAccent,
          width: 0.8,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'question',
            // fillColor: Colors.grey[300],
            // filled: true,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
          onSaved: (value) => ques = value,
        ),
      ),
    );
  }

  buildTextFormField2() {
    return Card(color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.pinkAccent,
          width: 0.8,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, top: 5, bottom: 28),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'answer',
            // fillColor: Colors.grey[300],
            // filled: true,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
          onSaved: (value) => ans = value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(children:<Widget>[buildTextFormField(),buildTextFormField2()], ),
          ),SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: createData,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Create', style: TextStyle(color: Colors.white)),
                ),
                color: Color(0xffF5637F),
              ),
              // RaisedButton(
              //   onPressed: id != null ? readData : null,
              //   child: Text('Read', style: TextStyle(color: Colors.white)),
              //   color: Colors.blue,
              // ),
            ],
          ),SizedBox(height: 10,),
          StreamBuilder<QuerySnapshot>(
            stream: db.collection('faqs1').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children: snapshot.data.docs
                        .map((doc) => buildItem(doc))
                        .toList());
              } else {
                return Center(child: CircularProgressIndicator(strokeWidth: 3,));
              }
            },
          )
        ],
      ),
    );
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db
          .collection('faqs1')
          .add({'ques': ques,'ans':ans});
      setState(() => id = ref.id);
      print(ref.id);
    }
  }

  void readData() async {
    DocumentSnapshot snapshot = await db.collection('faqs1').doc(id).get();
    // print(snapshot.data['ques']);
  }

  void updateData(DocumentSnapshot doc) async {
    await db
        .collection('faqs1')
        .doc(doc.id);
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('faqs1').doc(doc.id).delete();
    setState(() => id = null);
  }

  Future alertbox(doc) async {
    String condition = "Delete";
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // title: Text('Alert'),
        content: Text('Are you sure you want to delete:'),
        actions: <Widget>[
          FlatButton(
            onPressed:()=>{
              deleteData(doc),
              Navigator.of(ctx).pop()

            },
            child: Text(condition),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('cancel'),
          )
        ],
      ),
    );
  }
}
