
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ReportFoundItem.dart';
import 'ReportLostItem.dart';
import 'lists.dart';
import  'FoundItems.dart';
class TestPageWidget extends StatefulWidget {
  const TestPageWidget({Key? key}) : super(key: key);

  @override
  _TestPageWidgetState createState() => _TestPageWidgetState();
}

class _TestPageWidgetState extends State<TestPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0.2),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: ElevatedButton(
                        onPressed: () {
                         
 Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportFoundItemWidget()),);

                        }, style: ElevatedButton.styleFrom(
              primary: Colors.green,
             onPrimary : Colors.white,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              minimumSize: Size(130, 40), //////// HERE
            ), child: Text("Report Found item"),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 ElevatedButton(
                    onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportLostItemWidget()),);
                    },
                    style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              minimumSize: Size(130, 40), //////// HERE
            ), child: Text("Report Lost"),
                    ),
                    ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Founditems()),);
                    },
                    style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              minimumSize: Size(130, 40), //////// HERE
            ), child: Text("Go to lists"),
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
