import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ReportFoundItem.dart';
class FoundItemsWidget extends StatefulWidget {
  const FoundItemsWidget({Key? key}) : super(key: key);

  @override
  _FoundItemsWidgetState createState() => _FoundItemsWidgetState();
}

class _FoundItemsWidgetState extends State<FoundItemsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int pageIndex=0;
final pages = [
    const FoundItemsWidget(),
    const ReportFoundItemWidget()
    
  ];
  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
     // context.pushNamed('ReportFoundItem');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
       
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                pageIndex = 0;
              });
              },
              icon: pageIndex==0? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                pageIndex = 1;
              });
              },
              icon: pageIndex == 1
                ? const Icon(
                    Icons.work_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.work_outline_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
               ),
                ]
            ),
           
            ),
      key: scaffoldKey,
      backgroundColor:Colors.white,
      drawer: Drawer(
        elevation: 16,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/proj1-1991l8/assets/j5ncnqj9jkem/user_image.png',
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                child: Text(
                  'My Profile',
                  textAlign: TextAlign.center,
                  style:TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                ),
              ),
              ListTile(
                title: Text(
                  'My Posts',
                 style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF303030),
                  size: 20,
                ),
                tileColor: Color(0xFFF5F5F5),
                dense: false,
              ),
              ListTile(
                title: Text(
                  'Change Password',
                 style: TextStyle(color: Colors.black),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF303030),
                  size: 20,
                ),
                tileColor: Color(0xFFF5F5F5),
                dense: false,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.alignJustify,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Text(
          'Found',
          style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 35,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
      children:[
        StreamBuilder(
        
                              
        stream: FirebaseFirestore.instance.collection("Found_items").snapshots(),
        builder:(context,AsyncSnapshot snapshot){
           if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
          return Container(
            height: 500,
            width: 1000,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                DocumentSnapshot users = snapshot.data?.docs[index];
                return 
                //ListTile(
                  //title: Text(users['Name']),
                  //subtitle: Text(users['Message']),
               


                    SizedBox(
                      width: size.width* 0.8, 
                      child: ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                            child: Container(
                              width: 270,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Card(
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        color: Color(0xFFF5F5F5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              12, 12, 12, 12),
                                          child: Image.network(
                                            users['ImageURL'],
                                            width: double.infinity,
                                            height: 300,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        users['Message'],
                                        style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 25,
                                            ),
                                      ),
                                      Text(
                                       users['PhoneNumber'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        users['Name'],
                                        style:
                                           TextStyle(color: Colors.black),
                                      ),
                                       Text(
                                       users['WhereFound'],
                                        style:
                                           TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                 
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );}
                  ),
          );
        
                              
                },
              
        ),
          
              ],
            ),
            
          );
       


  }
}
  

  



  


