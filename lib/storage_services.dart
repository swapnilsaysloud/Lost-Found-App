import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart'as firebase_core;
import 'package:proj1/ReportLostItem.dart';
String imageURL='';
class Storage{

  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

Future<String> uploadFile(
  String filePath,
  String fileName,
)async{
  File file = File(filePath);
String UniqueFileName= DateTime.now().second.toString();
  try {
   // await storage.ref('test/$fileName').putFile(file);
       await storage.ref().child('images').child(filePath + UniqueFileName).putFile(File(file!.path));
       imageURL=await storage.ref().child('images').child(filePath + UniqueFileName).getDownloadURL();
  } on firebase_core.FirebaseException   catch (e) {
    print(e);
  }
   return imageURL;
}

    
   }
  


