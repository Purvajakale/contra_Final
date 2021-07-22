import 'package:contra_care/services/admin_faqs_update.dart';
import 'package:contra_care/services/admin_pills_update.dart';
import 'package:contra_care/services/faq1update.dart';
// import 'package:contra_care/services/new.dart';
import 'package:contra_care/views/user_queries.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AdminPanel extends StatefulWidget {
  //const AdminPanel({ Key? key }) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signOut() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Logout'),
        content: Text(
            'You have been successfully logged out, now you will be redirected to Homepage'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
    return await _auth.signOut();
  }

  User user;
  bool isloggedin = false;
  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('admin'),
        backgroundColor: Color(0xff7c83fd), elevation: 0,
      ),
      drawer: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 26, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Color(0xffaeb3fe)),
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.70,
            child: ListView(
              children: [
                Container(
                  height: 150,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xffaeb3fe),
                        Colors.grey[100],
                      ]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/profile.jpg',
                          height: 100,
                          width: 80,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Admin",
                                style: TextStyle(
                                    fontSize: 25,fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PillInfoUpdate()));
                  },
                  child: ListTile(
                    title: Text("Update Pills data"),
                    trailing: Icon(Icons.medication),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FaqUpdate()));
                  },
                  child: ListTile(
                    title: Text("Update FAQs"),
                    trailing: Icon(Icons.info),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserQuery()));
                  },
                  child: ListTile(
                    title: Text("User queries"),
                    trailing: Icon(Icons.query_builder),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text("Logout"),
                    trailing: Icon(Icons.logout),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45)),
                    color: Color(0xff7c83fd)),
                child: Padding(
                    padding:
                    const EdgeInsets.all(30).copyWith(left: 38, top: 5,bottom: 10),
                    child: Text(
                      'Welcome to \nAdmin page',
                      style: GoogleFonts.quicksand(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[200],
                      ),
                    )),
              ),
              SizedBox(height: 30,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Neumorphic(
                          style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                              color: Color(0xff7c83fd),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                NeumorphicButton(
                                    margin: EdgeInsets.only(top: 12),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => UserQuery()));
                                    },
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.circle(),
                                      color: Color(0xff7c83fd),
                                    ),
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(
                                      Icons.info,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "See Queries",
                                    style: TextStyle(color: Colors.white, fontSize: 18, ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Neumorphic(
                          style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                              color: Color(0xff7c83fd),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                NeumorphicButton(
                                    margin: EdgeInsets.only(top: 12),
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Navigator.pop(context);
                                      },
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.circle(),
                                      color: Color(0xff7c83fd),
                                    ),
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(
                                      Icons.logout,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "     Logout     ",
                                    style: TextStyle(color: Colors.white, fontSize: 18, ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Neumorphic(
                          style: NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                            color: Color(0xff7c83fd),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                NeumorphicButton(
                                  margin: EdgeInsets.only(top: 12),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => PillInfoUpdate()));
                                  },
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: Color(0xff7c83fd),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.medication,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Update Pills",
                                    style: TextStyle(color: Colors.white, fontSize: 18, ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Neumorphic(
                          style: NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                            color: Color(0xff7c83fd),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                NeumorphicButton(
                                  margin: EdgeInsets.only(top: 12),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => FaqUpdate()));
                                  },
                                  style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: Color(0xff7c83fd),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.add,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "Upgate FAQs",
                                    style: TextStyle(color: Colors.white, fontSize: 18, ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}