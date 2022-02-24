import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class Pills1Update extends StatefulWidget {
  @override
  Pills1UpdateState createState() {
    return Pills1UpdateState();
  }
}

class Pills1UpdateState extends State<Pills1Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 20, 5),
              child: Text("Diabetes",
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
            child: pills1(),
          ),
        ],
      ),
    );
  }
}

class pills1 extends StatefulWidget {
  const pills1({Key key}) : super(key: key);

  @override
  _pills1State createState() => _pills1State();
}

class _pills1State extends State<pills1> {
  String id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;

  Card buildItem(DocumentSnapshot doc) {
    return Card( shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),side: BorderSide(
      color: Colors.pinkAccent,
      width: 0.8,
    ),
    ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 0,top: 8),
              child: Text(
                doc['name'],
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 8),
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
    return Card(color: Colors.white, shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),side: BorderSide(
      color: Colors.pinkAccent,
      width: 0.8,
    ),
    ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15,top: 5,bottom: 5),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter Pill Name',
            // fillColor: Colors.grey[100],
            // filled: true,
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            } return null;
          },
          onSaved: (value) => name = value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Form(
              key: _formKey,
              child: buildTextFormField(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                  onPressed: createData,
                  child: Text('Create', style: TextStyle(color: Colors.white)),
                  color: Color(0xffF5637F),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: db.collection('table1').snapshots(),
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
      ),
    );
  }

  void createData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db
          .collection('table1')
          .add({'name':name});
      setState(() => id = ref.id);
      print(ref.id);
    }
  }

  void updateData(DocumentSnapshot doc) async {
    await db
        .collection('table1')
        .doc(doc.id);
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('table1').doc(doc.id).delete();
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
