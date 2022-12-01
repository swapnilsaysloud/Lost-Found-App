import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ReportFoundItem.dart';
import 'ReportLostItem.dart';
import 'lists.dart';
import 'LostItems.dart';
import 'OnBoardingScreen.dart';
import 'onboarding_page(Conc).dart';

class LoggedInPageWidget extends StatefulWidget {
  const LoggedInPageWidget({Key? key}) : super(key: key);
 
  @override
  _LoggedInPageWidgetState createState() => _LoggedInPageWidgetState();
}

class _LoggedInPageWidgetState extends State<LoggedInPageWidget> {

 final FirebaseAuth _auth = FirebaseAuth.instance;
 Future signOut()async{
  try{
    return await _auth.signOut();
  }catch(e){
    print(e.toString());
    return null;
  }
 }


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            'Lost/Found',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 12),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Button pressed ...');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ReportFoundItemWidget()),
                          );
                        },
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 0, 0, 0)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: Color.fromARGB(255, 8, 7, 7))))),
                        child: Text('Report Found item'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ReportLostItemWidget()),
                          );
                        },
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 0, 0, 0)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: Color.fromARGB(255, 8, 7, 7))))),
                        child: Text('Report Lost item'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                      child: SizedBox(
                        width: 10.0,
                        child: ElevatedButton(
                          onPressed: () {
                            print('Button pressed ...');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Founditems()),
                            );
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 0, 0, 0)),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                  
                                      borderRadius: BorderRadius.circular(8.0),
                                      
                                      side: BorderSide(
                                          color: Color.fromARGB(255, 8, 7, 7))))),
                          child: Text('Found Items'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          print('Button pressed ...');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LostItems()),
                          );
                        },
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 0, 0, 0)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                        color: Color.fromARGB(255, 8, 7, 7))))),
                        child: Text('Lost items'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: ElevatedButton(
                        onPressed: () async{
                          print('Button pressed ...');
                          await signOut();
                          

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  OnboardingPage()),
                          );
                        },
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 0, 0, 0)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    ))),
                        child: Text('Sign out'),
                      ),
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
