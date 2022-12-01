import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'NewLoggedIn.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User? user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
         backgroundColor: Colors.transparent,
        appBar: AppBar(
              backgroundColor: Colors.white,
         title: Text(
              'Verify Email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 22,
              ),
            ),
                 centerTitle: true,
                  iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text('An email is sent to "${user?.email}". please verify your account ', textAlign: TextAlign.center,style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 25,
                ),
                ),
          
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user?.reload();
    if (user!.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NewLoggedIn()));
    }
  }
}
