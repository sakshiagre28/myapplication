import 'package:cloud_firestore/cloud_firestore.dart';

class Policy{
  final String pid;
  final String category;
  final String details;
  final String documents;
  final String link;
  final String name;

  Policy({this.pid,this.category,this.details,this.documents,this.link,this.name});

  factory Policy.fromDoc(DocumentSnapshot doc){
      return Policy(
        pid: doc.documentID,
      category : doc['Category'],
      details : doc['Details'],
      documents : doc['Documents'],
      link : doc['Link'],
      name : doc['Name']
      );
  }
}