import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homePage.dart';

class MainActivity extends StatefulWidget {
  final String passedph;
  final String passedmorb;
  final String passedph2;
  final String passednam;
  final String passedad;
  const MainActivity(
      {Key key,
      this.passedph,
      this.passedmorb,
      this.passedph2,
      this.passednam,
      this.passedad});
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  Telephony telephony = Telephony.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      } else {
        Navigator.of(context).pushReplacementNamed("Button");
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

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID 19 EMERGENCY APP'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                onPressed: () async {
                  await telephony.sendSms(
                      to: '${widget.passedph}',
                      message:
                          'Emergency!\nName: ${widget.passednam}\nPhone No: - ${widget.passedph2}\nComorbidities: ${widget.passedmorb}\nAddress: ${widget.passedad}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(
                        passednum: '${widget.passedph}',
                      ),
                    ),
                  );
                },
                splashColor: Colors.red[200],
                child: Text('EMERGENCY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                color: Colors.redAccent[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                onPressed: signOut,
                child: Text('Signout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
                color: Colors.lightBlue[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
