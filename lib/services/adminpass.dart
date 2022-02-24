import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contra_care/views/adminpanel.dart';
import 'package:contra_care/views/home2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResetAdminpass extends StatefulWidget {
  @override
  _ResetAdminpassState createState() => _ResetAdminpassState();
}

class _ResetAdminpassState extends State<ResetAdminpass> with Validator {
  final snackBar = SnackBar(content: Text('Password Changed successfully'));

  String id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final double minValue = 8.0;

  int experienceIndex = 0;

  final TextStyle _errorStyle = TextStyle(
    color: Colors.red,
    fontSize: 16.6,
  );

  @override
  void initState() {
    _onCreated();
    super.initState();
  }

  void _onCreated() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  String password, email;

  final Color activeColor = Colors.black;
  final Color inActiveColor = Colors.white;

  void updateData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref;
      await db
          .collection('password')
          .doc('eKurKQJXUaZwlLbkGrg1')
          .update({'e-mail': email, 'password': password});
      // setState(() => id = ref.id);
      // print(ref.id);
      final snackBar = SnackBar(
        content: Text('Password updated'),
        action: SnackBarAction(
          label: 'Back to Home Page',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminPanel()));
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // void createData() async {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //    // DocumentReference ref = await db
  //         .collection('password')
  //         .doc('eKurKQJXUaZwlLbkGrg1')
  //         .update({'e-mail':email,'password': password})
  //         .then((_) => print('Success'));
  //         .catchError((error) => print('Failed: $error'));
  //     // .up({'e-mail': email, 'password': password});
  //     setState(() => id = ref.id);
  //     print(ref.id);
  //     final snackBar = SnackBar(
  //       content: Text('Password updated'),
  //       action: SnackBarAction(
  //         label: 'Back to Home Page',
  //         onPressed: () {
  //           Navigator.push(
  //               context, MaterialPageRoute(builder: (context) => AdminPanel()));
  //         },
  //       ),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  Widget _buildName() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextFormField(
        controller: _nameController,
        validator: usernameValidator,
        keyboardType: TextInputType.text,
        // decoration: new InputDecoration(
        //     errorStyle: _errorStyle,
        //     border: InputBorder.none,
        //     contentPadding:
        //     EdgeInsets.symmetric(vertical: minValue, horizontal: minValue),
        //     labelText: 'Full  Name',
        //     labelStyle: TextStyle(fontSize: 16.0, color: Colors.grey.shade500)),
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide:
              const BorderSide(color: Color(0xffEB6383), width: 0.7),
            ),
            border: const OutlineInputBorder(),
            hintText: "new password",
            hintStyle: TextStyle(color: Colors.grey[600])),
        onSaved: (value) => password = value,
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.text,
          validator: validateEmail,
          onChanged: (String value) {},
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide:
                const BorderSide(color: Color(0xffEB6383), width: 0.7),
              ),
              border: const OutlineInputBorder(),
              hintText: "new email-id",
              hintStyle: TextStyle(color: Colors.grey[600])),
          onSaved: (value) => email = value,
        ));
  }

  Widget _buildSubmitBtn() {
    return Container(
      width: 260,
      padding: EdgeInsets.symmetric(horizontal: minValue * 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient:
        LinearGradient(colors: [Color(0xfffbccd5), Color(0xffF5637F)]),
      ),
      child: RaisedButton(
        onPressed: updateData,
        padding: EdgeInsets.symmetric(vertical: minValue * 2.4),
        elevation: 0.0,
        color: Colors.transparent,
        textColor: Colors.white,
        child: Text('SAVE'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: minValue * 18,
                    ),
                    Text(
                      "Update Password",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 160.0,
                      child: Container(
                        height: 4,
                        color: Color(0xffFF9BA6),
                        // color: Colors.pink[400],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: minValue * 1,
                    ),
                    Form(
                        key: _formKey,
                        //child: Column(children:<Widget>[_buildName(),_buildEmail(),_buildDescription(),], ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: minValue * 2,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                // height: 150,
                                // decoration: BoxDecoration(
                                //     color: Colors.grey[100], borderRadius: BorderRadius.circular(25)),
                                child: _buildEmail(),
                              ),
                              SizedBox(
                                height: minValue * 2,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                // height: 150,
                                // decoration: BoxDecoration(
                                //     color: Colors.grey[100], borderRadius: BorderRadius.circular(25)),
                                child: _buildName(),
                              ),
                              SizedBox(
                                height: minValue * 2,
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: minValue * 4,
                    ),
                    _buildSubmitBtn(),
                    SizedBox(
                      height: minValue * 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Validator {
  static bool isEmail(String email) => EmailValidator.validate(email);

// Making Form Email Validation
  String validateEmail(String value) {
    bool isEmail(String email) => EmailValidator.validate(email);
    String msg = '';
    if (!isEmail(value.trim())) {
      msg = 'Please enter a valid email';
    } else {
      msg = null;
    }
    return msg;
  }

  String usernameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    } else if (value.length < 4) {
      return 'Name must be 4';
    }
  }
}

// class MyComponentsLoader extends StatelessWidget {
//   final Color color;
//
//   MyComponentsLoader({this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return CircularProgressIndicator();
//   }
// }