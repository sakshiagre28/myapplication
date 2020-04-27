import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/models/user.dart';
import 'package:myapplication/screens/editprofile.dart';
import 'package:myapplication/utilities/constants.dart';

class ProfileScreen extends StatefulWidget {
  static final String id = 'profileScreen';

  final String userId;
  ProfileScreen({this.userId});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          
          child: Padding(
            padding: EdgeInsets.only(left: 80.0),
            child: Text(
              'My account',
              style: TextStyle(
                color: Color(0xFFD9E6F2),
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFF213458),
      ),
      body: FutureBuilder(
          future: userRef.document(widget.userId).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            User user = User.fromDoc(snapshot.data);
           
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFFD9E6F2),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(50.0),
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundImage: user.profileImageUrl.isEmpty
                          ? AssetImage('assets/Portrait_Placeholder.png')
                          : CachedNetworkImageProvider(user.profileImageUrl),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Name',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Color(0xFF213458),
                                ),
                              ),
                              //SizedBox(width: 30.0,),
                              Expanded(
                                child: Text(
                                  user.name,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Color(0xFF213458),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Color(0xff016064),
                        height: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Email',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Color(0xFF213458),
                                ),
                              ),
                              //SizedBox(width: 30.0,),
                              Expanded(
                                child: Text(
                                  user.email,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Color(0xFF213458),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Color(0xff016064),
                        height: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Phone',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Color(0xFF213458),
                                ),
                              ),
                              //SizedBox(width: 30.0,),
                              Expanded(
                                child: Text(
                                  '+91' + user.phone,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Color(0xFF213458),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Color(0xff016064),
                        height: 5.0,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Password',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Color(0xFF213458),
                                ),
                              ),
                              //SizedBox(width: 30.0,),
                              Expanded(
                                child: Text(
                                 user.password,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Color(0xFF213458),
                                    
                                  ),
                                
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30.0),
                        child: Container(
                            height: 50.0,
                            width: 190.0,
                            child: RaisedButton(
                              child: Text('Edit Profile',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => EditProfile(user: user))),
                              color: Color(0xFF213456),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
