import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proj1/storage_services.dart';
import 'auth_services.dart';
import 'package:provider/provider.dart';
import 'Test.dart';
import 'LoggedInPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'verify.dart';

class NewSignupWidget extends StatefulWidget {
  const NewSignupWidget({Key? key}) : super(key: key);

  @override
  _NewSignupWidgetState createState() => _NewSignupWidgetState();
}

class _NewSignupWidgetState extends State<NewSignupWidget> {
  bool isMediaUploading = false;
  String uploadedFileUrl = '';
  late String ProfileLink='';
  late String imageurl='';
  final _formkey = GlobalKey<FormState>();
  TextEditingController textController1 = new TextEditingController(); //name
  TextEditingController textController2 =
      new TextEditingController(); //phonenumber
  TextEditingController textController3 =
      new TextEditingController(); // Webmail
  TextEditingController textController4 =
      new TextEditingController(); // password
  TextEditingController textController5 =
      new TextEditingController(); // Confirm Password

  late bool passwordVisibility1;
  //TextEditingController? textController5;

  late bool passwordVisibility2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    passwordVisibility1 = false;
    textController5 = TextEditingController();
    passwordVisibility2 = false;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    textController5?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Fill up information',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: Container(
                          width: 120,
                          height: 120,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ProfileLink=='' ?  Image.network(
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/proj1-1991l8/assets/j5ncnqj9jkem/user_image.png',
                          ): Image.network(ProfileLink),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            child: InkWell(
                              onTap: () async {

                                
   ImagePicker imagePicker = ImagePicker();
                    XFile? file1 =
                        await imagePicker.pickImage(source: ImageSource.gallery);
                    print('${file1?.path}');


                             /*final results = await FilePicker.platform.pickFiles(allowMultiple: false ,
                        type: FileType.custom,
                        allowedExtensions: ['png','jpg'],
                        );*/
                        if(file1==null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No File Selected'),
                          )
                          );
                          return null;
                        }
 String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    /*Step 2: Upload to Firebase storage*/
                    //Install firebase_storage
                    //Import the library

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);

                    //Handle errors/success
                    try {
                      //Store the file
                      await referenceImageToUpload.putFile(File(file1!.path)).then((value) async =>  Fluttertoast.showToast(msg: 
                          'Image uploaded', toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,timeInSecForIosWeb: 4,backgroundColor: Colors.grey,textColor: Colors.black,fontSize: 15)) ;
                      //Success: get the download URL
                      imageurl = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      //Some error occurred
                    }
                    setState(() {
                      ProfileLink=imageurl; 
                    });
                               /* final results =
                                    await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['png', 'jpg'],
                                );
                                if (results == null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('No File Selected'),
                                  ));
                                  return null;
                                }
                                final path = results!.files.single.path!;
                                final fileName = results!.files.single.name!;
                                print(path);
                                print(fileName);

                                storage
                                    .uploadFile(path, fileName)
                                    .then((value) => print('Done'));*/

                              },
                              child: Text(
                                'Upload your picture here',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          /* FutureBuilder
                          (future: storage.listFiles(),
                            builder: (BuildContext context , AsyncSnapshot<firebase_storage.ListResult> snapshot){
if(snapshot.connectionState== ConnectionState.done && snapshot.hasData)
{
  return Container(
      height: 100,
      child: ListView.builder
      (scrollDirection: Axis.horizontal,
      shrinkWrap: true,
        itemCount: snapshot.data!.items.length,
      itemBuilder: (BuildContext context, int index){
       return ElevatedButton(
          onPressed: (){},
          child: Text(snapshot.data!.items[index].name),
          );
      }),
  );
}
if(snapshot.connectionState== ConnectionState.waiting || !snapshot.hasData)
{
  return CircularProgressIndicator();
}
return Container();
                            })*/
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 12),
                        child: TextFormField(
                          controller: textController1,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 13, 12, 12)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF8F1F1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: TextFormField(
                          controller: textController2,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter Phone number',
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 13, 12, 12)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: TextFormField(
                          controller: textController3,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter Webmail',
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 13, 12, 12)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: TextFormField(
                          controller: textController4,
                          autofocus: true,
                          obscureText: !passwordVisibility1,
                          decoration: InputDecoration(
                            hintText: 'Set Password',
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 13, 12, 12)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () =>
                                    passwordVisibility1 = !passwordVisibility1,
                              ),
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                passwordVisibility1
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: TextFormField(
                          controller: textController5,
                          autofocus: true,
                          obscureText: !passwordVisibility2,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromARGB(255, 13, 12, 12)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () =>
                                    passwordVisibility2 = !passwordVisibility2,
                              ),
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                passwordVisibility2
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final String name = textController1.text.trim();
                          final String phoneNumber =
                              textController2.text.trim();
                          final String Webmail = textController3.text.trim();
                          final String Password = textController4.text.trim();
                          final String confirmpassword =
                              textController5.text.trim();

                          /* Future signup() async{
                        if(Password==confirmpassword){
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: Webmail, password: Password);
                        }
                       }*/
                          if (name != '' &&
                              phoneNumber != '' &&
                              Webmail != '' &&
                              Password != '') {
                           
                            if (Webmail.isEmpty) {
                              print("Email is Empty");
                            } else {
                              if (Password.isEmpty) {
                                print("Password is Empty");
                              } else {
                                context
                                    .read<AuthService>()
                                    .login(
                                      Webmail,
                                      Password,
                                    )
                                    .then((value) async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  var uid = user?.uid;

                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc( user?.uid)
                                      .set({
                                    'uid': user?.uid,
                                    'Name': name,
                                    'Webmail': Webmail,
                                    'Password': Password,
                                    'Phone Number': phoneNumber,
                                    'ImageURL':imageurl

                                    //'name':null,
                                    //'PhoneNumber':null,
                                    //'Webmail':null
                                  });
                                });
                              }
                            }
                           signUp(Webmail, Password);
                           /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LoggedInPageWidget()),
                            );*/
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please fill the full form',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 4,
                                backgroundColor: Colors.grey,
                                textColor: Colors.black,
                                fontSize: 15);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.white,
                          shadowColor: Colors.greenAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          minimumSize: Size(130, 40), //////// HERE
                        ),
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((_) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => VerifyScreen()));
        throw '';
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
