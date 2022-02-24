import 'package:contra_care/features/reminders/screens/home/home.dart';
import 'package:contra_care/views/about_us.dart';
import 'package:contra_care/views/brandsinfo.dart';
import 'package:contra_care/views/carouselslider.dart';
import 'package:contra_care/views/data/readinfo.dart';
import 'package:contra_care/views/data/readmore.dart';
import 'package:contra_care/views/faqs.dart';
import 'package:contra_care/views/onboarding%20screen/onboard_main.dart';
import 'package:contra_care/views/queryform.dart';
import 'package:contra_care/views/translatordemo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  Future signOut() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Logout'),
        content: Text(
            'You have been successfully logged out, now you will be redirected to HomePage'),
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

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Onboarding()),
        );
      }
    });
  }

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
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xffF5637F),
        elevation: 0,
      ),
      drawer: Padding(
        padding: EdgeInsets.only(top: 16, bottom: 5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Color(0xfff78298)),

          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.875,
          // height: 800,
          child: ListView(
            children: [
              Container(
                height: 150,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xfff78298),
                      Color(0xfffbccd5),
                    ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/profile.png',
                        height: 100,
                        width: 80,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                new AlertDialog(
                                  title: Text('${user.displayName}'),
                                  content: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${user.email}'),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    new TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              "My profile",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: ListTile(
                  title: Text(
                    "Pills Tracker",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Icon(
                    Icons.alarm,
                    size: 28,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PillsBrands()));
                },
                child: ListTile(
                  title: Text(
                    "Symptoms",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Icon(
                    Icons.medication_outlined,
                    size: 28,
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FormFour()));
                },
                child: ListTile(
                  title: Text(
                    "Ask query",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Icon(
                    Icons.query_stats,
                    size: 28,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FaqsPage()));
                },
                child: ListTile(
                  title: Text(
                    "FAQs",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Icon(
                    Icons.live_help_outlined,
                    size: 28,
                  ),
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => AboutUs()));
              //   },
              //   child: ListTile(
              //     title: Text(
              //       "About us",
              //       style: TextStyle(fontSize: 17),
              //     ),
              //     trailing: Icon(
              //       Icons.person,
              //       size: 28,
              //     ),
              //   ),
              // ),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Icon(
                    Icons.logout,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // backgroundColor: Color(0xfff8f8f8),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xffF5637F),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(45)),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(right: 15, top: 20, bottom: 40),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 30, right: 18, bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            "Welcome to, \nAarog!",
                            style: GoogleFonts.quicksand(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[100],
                            ),
                          ),
                          Container(
                            child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Image.asset(
                                  "assets/images/img2.png",
                                  fit: BoxFit.contain,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 80,),
                  SingleChildScrollView(
                    child: Container(
                      color: Color(0xffFFFDF9),
                      child: RecomendsPlants(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: height*0.5,),
          Padding(
            padding: const EdgeInsets.only(bottom: 5).copyWith(top: height*0.43),
            child: ReadInfoPage(),
          ),
        ],
      ),
    );
  }
}