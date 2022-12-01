/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'LoginPage.dart';
import 'NewSignUp.dart';
class OnBoardingScreenWidget extends StatefulWidget {
  const OnBoardingScreenWidget({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenWidgetState createState() => _OnBoardingScreenWidgetState();
}

class _OnBoardingScreenWidgetState extends State<OnBoardingScreenWidget> {
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: 1000,
          child: PageView(
            controller: pageViewController ??= PageController(initialPage: 0),
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Spacer(flex: 2,),
                    Lottie.network(
                      'https://assets2.lottiefiles.com/private_files/lf30_3X1oGR.json',
                      width: 150,
                      height: 130,
                      fit: BoxFit.cover,
                    
                      animate: true,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 15),
                      
                        child: 
                        ElevatedButton(
                          
                           style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(130, 40), //////// HERE
            ),
                          onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const NewSignupWidget()),);
                          }, child: Text("Get Started"),
                        ),
                      ),
                   
                    InkWell(
                      onTap: () async {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPageWidget()),);
                      },
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/






// New code

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'LoginPage.dart';
import 'NewSignUp.dart';

class OnBoardingScreenWidget extends StatefulWidget {
  const OnBoardingScreenWidget({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenWidgetState createState() => _OnBoardingScreenWidgetState();
}

class _OnBoardingScreenWidgetState extends State<OnBoardingScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor:Color.fromARGB(255, 161, 224, 233),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  Container(
                    height: 400,
                    width:400,
                    child: Image(image: const AssetImage("assets/images/logo2.png")),
                  )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 20),
                child: ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NewSignupWidget()),);
                  },
                  
                  style: ButtonStyle(
                   
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 0, 0, 0)),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.green),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(
                                          color: Color.fromARGB(255, 8, 7, 7))))),
                          child: Text('Get Started',style:  const TextStyle(color: Colors.white),),
                ),
              ),
              ElevatedButton(
                onPressed: () {
             
                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginPageWidget()),);
                },
               style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 0, 0, 0)),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.green),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(
                                          color: Color.fromARGB(255, 8, 7, 7))))),
                          child: Text('Login',style:  const TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

