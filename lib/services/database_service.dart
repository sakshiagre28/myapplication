import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapplication/models/user.dart';
import 'package:myapplication/utilities/constants.dart';

class DatabaseService{

  static void updateUser(User user){
    userRef.document(user.id).updateData({
      'name': user.name,
      'imageUrl': user.profileImageUrl,
      'email': user.email,
      'phone': user.phone,
      'password': user.password
    });
  }

  static Future<QuerySnapshot> searchPolicy(String inputPolicy) { 
    Future<QuerySnapshot> policies = Firestore.instance.collection('policies')
    .where('Name', isGreaterThanOrEqualTo: inputPolicy).getDocuments();
    return policies;
  }
}