import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ReportFoundItem.dart';
import 'Profile.dart';
 User? user = FirebaseAuth.instance.currentUser;
 var uid = user?.uid;
 int pageIndex=0;


class MyPosts extends StatelessWidget {
  const MyPosts({super.key});

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return  Scaffold(
       drawer:Drawer(
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
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                width: 120,
                height: 100,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                 "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80",
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                child: Text(
                  'Hello Swapnil !!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: ListTile(
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyPosts()),
                    );
                  },
                ),
              ),
              SizedBox(
                width: size.width * 0.8,
                child: ListTile(
                  title: Text(
                    'My Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF303030),
                    size: 20,
                  ),
                  tileColor: Color.fromARGB(255, 0, 0, 0),
                  dense: false,
                   onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileWidget()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
resizeToAvoidBottomInset : false,

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 161, 224, 233),
        title: Text(
          'My Posts',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      

      body:
          StreamBuilder(
            
                                  
            stream: FirebaseFirestore.instance.collection("Found_Lost_items").where("uid",isEqualTo: user?.uid).snapshots(),
            builder:(context,AsyncSnapshot snapshot){
               if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context,index){
                  DocumentSnapshot users = snapshot.data?.docs[index];
                  return /*ListTile(
                    
                    title: Text(users['Name']),
                    subtitle: Text(users['Message']),
                    trailing: Text(users['PhoneNumber']),
                  );*/
                   SizedBox(
                          width: size.width, 
                          child: ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                                child: Container(
                                  width: 270,
                                  height: 450,
                                  decoration: BoxDecoration(
                                    color:  Color.fromARGB(255, 161, 224, 233),
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
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                            flex: 0,
                                              child: Card(
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
                                      ),
                                     
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );}
    );
            } ,
            ),
    );





  }
}