import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String profileImageUrl;
  final String email;
  final String phone;
  final String password;

  User({this.id, this.name, this.profileImageUrl, this.email, this.phone, this.password});

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      name: doc['name'],
      profileImageUrl: doc['imageUrl'] ?? '',
      email: doc['email'],
      phone: doc['phone'],
      password: doc['password']
    ); 
  }
}
