import 'dart:io';
 
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:myapplication/utilities/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageService{

  static Future<String> uploadUserProfileImage(String url, File imageFile) async{
    String photoId = Uuid().v4();  //v4: autogenerate id
    File image = await compressImage(photoId, imageFile);

    if (url.isNotEmpty) {
      RegExp exp =  RegExp(r'userProfile_(.*).jpg');
      photoId = exp.firstMatch(url)[1];
      print(photoId);
    }

    StorageUploadTask uploadTask = storageRef
    .child('images/users/userProfile_$photoId.jpg')
    .putFile(image);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<File> compressImage(String photoId, File image) async{
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,              //path: path of 'image'(line14)
      '$path/img_$photoId.jpg',        //targetpath:path of 'path'(line16)
      quality: 70,
      );
    return compressedImageFile;  
  }
}