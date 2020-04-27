import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyDetailScreen extends StatefulWidget {
  static final id = 'policydetailscreen';
  String policyName;
  PolicyDetailScreen({this.policyName});
  @override
  _PolicyDetailScreenState createState() => _PolicyDetailScreenState();
}

class _PolicyDetailScreenState extends State<PolicyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9E6F2),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('policies')
              .where('Name', isEqualTo: widget.policyName)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
                children: snapshot.data.documents.map<Widget>(
              (document) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('DETAILS:',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Color(0xFF213458),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              document['Details'],
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color(0xFF213458),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('LINK:',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Color(0xFF213458),
                                )),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                child: Text(document['Link']),
                                onTap: () => launch(document['Link']),
                              )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              RaisedButton(
                                child: Text('I Applied',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                onPressed: () => print(widget.policyName),
                                color: Color(0xFF213456),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ).toList());
          }),
    );
  }
}
