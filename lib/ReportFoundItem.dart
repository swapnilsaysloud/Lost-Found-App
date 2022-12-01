import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'Test.dart';
import 'NewSignUp.dart';
import 'storage_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'LoggedInPage.dart';
import 'NewLoggedIn.dart';
String ? imageurl;
class ReportFoundItemWidget extends StatefulWidget {
  const ReportFoundItemWidget({Key? key}) : super(key: key);

  @override
  _ReportFoundItemWidgetState createState() => _ReportFoundItemWidgetState();
}

class _ReportFoundItemWidgetState extends State<ReportFoundItemWidget> {
  bool isMediaUploading = false;
  String uploadedFileUrl = '';
   late String ProfileLink='';

  TextEditingController textController1 = new TextEditingController(); //name
  TextEditingController textController2 =
      new TextEditingController(); //phonenumber
  TextEditingController textController3 =
      new TextEditingController(); // Where did you find
  TextEditingController textController4 =
      new TextEditingController(); //  Message
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    textController3?.dispose();
    textController4?.dispose();
    super.dispose();
  }

  final databaseReference = FirebaseFirestore.instance;
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
                    Align(
                      alignment: AlignmentDirectional(-0.97, 0),
                    ),
                    ProfileLink==''? Image.network(
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/proj1-1991l8/assets/5n8m5lmnwd0b/report_found.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ):Image.network(ProfileLink,width:double.infinity,fit: BoxFit.cover),
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
                        ProfileLink=imageurl!; 
                      });
                         

                           /* final path = file1.files.single.path!;
                            final fileName= file1.files.single.name!;
                            String UniqueFileName= DateTime.now().millisecondsSinceEpoch.toString();
                            print (path);
                            print(fileName);
                           File file = File(path);
                           imageurl= storage.uploadFile(path,fileName).then((value) async =>  Fluttertoast.showToast(msg: 
                            'Image uploaded', toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,timeInSecForIosWeb: 4,backgroundColor: Colors.grey,textColor: Colors.black,fontSize: 15)) as String?;*/
                            //final ref = FirebaseStorage.instance.ref('test/$fileName');
                           
                              //imageurl= await FirebaseStorage.instance.ref().child('images').child(UniqueFileName).getDownloadURL();
                            
                          
                              /*
                              final selectedMedia =
                                  await selectMediaWithSourceBottomSheet(
                                context: context,
                                maxWidth: 100.00,
                                maxHeight: 100.00,
                                allowPhoto: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                setState(() => isMediaUploading = true);
                                var downloadUrls = <String>[];
                                try {
                                  showUploadMessage(
                                    context,
                                    'Uploading file...',
                                    showLoading: true,
                                  );
                                  downloadUrls = (await Future.wait(
                                    selectedMedia.map(
                                      (m) async => await uploadData(
                                          m.storagePath, m.bytes),
                                    ),
                                  ))
                                      .where((u) => u != null)
                                      .map((u) => u!)
                                      .toList();
                                } finally {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  isMediaUploading = false;
                                }
                                if (downloadUrls.length == selectedMedia.length) {
                                  setState(
                                      () => uploadedFileUrl = downloadUrls.first);
                                  showUploadMessage(context, 'Success!');
                                } else {
                                  setState(() {});
                                  showUploadMessage(
                                      context, 'Failed to upload media');
                                  return;
                                }
                              }*/
                            },
                            child: Text(
                              'Upload Item\'s photo/video here',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
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
                              color: Color.fromARGB(255, 0, 0, 0)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF8F1F1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF8F1F1),
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
                              color: Color.fromARGB(255, 0, 0, 0)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF8F1F1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF8F1F1),
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
                          hintText: 'Where did you find it ??',
                          hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF8F1F1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF8F1F1),
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
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                      child: TextFormField(
                        controller: textController4,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Message',
                          hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF8F1F1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF8F1F1),
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
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        final String name = textController1.text.trim();
                        final String phoneNumber = textController2.text.trim();
                        final String WhereFound = textController3.text.trim();
                        final String message = textController4.text.trim();
                        String Time =
                          DateTime.now().millisecondsSinceEpoch.toString();
                        if(name!=''&& phoneNumber!=''&&WhereFound !='' && message!='')
                        {
                          await FirebaseFirestore.instance
                                    .collection("Found_items")
                                    .doc(name)
                                  .set({
                          'Name': name,
                          'PhoneNumber': phoneNumber,
                          'WhereFound': WhereFound,
                          'Message': message,
                          'ImageURL':imageurl,
                          'uid':user?.uid,
                          'Time':Time
                        });
                        await FirebaseFirestore.instance
                                    .collection("Found_Lost_items")
                                    .doc(name)
                                  .set({
                          'Name': name,
                          'PhoneNumber': phoneNumber,
                          'WhereFound': WhereFound,
                          'Message': message,
                          'ImageURL':imageurl,
                          'uid':user?.uid,
                          'Time':Time,
                          //'Color':"Colors.green"
                        });


                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewLoggedIn()),
                        );}
                        else{
                          Fluttertoast.showToast(msg: 
                          'Please fill the full form', toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,timeInSecForIosWeb: 4,backgroundColor: Colors.grey,textColor: Colors.black,fontSize: 15);
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
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
