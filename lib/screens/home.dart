import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/models/policymodel.dart';
import 'package:myapplication/models/user.dart';
import 'package:myapplication/models/userdata.dart';
import 'package:myapplication/screens/loginscreen.dart';
import 'package:myapplication/screens/feed.dart';
import 'package:myapplication/screens/notificationscreen.dart';
import 'package:myapplication/screens/policydetailscreen.dart';
import 'package:myapplication/screens/policynamescreen.dart';
import 'package:myapplication/screens/profilescreen.dart';
import 'package:myapplication/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:myapplication/services/database_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static final String id = 'home';

  

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String _currentPass;
  String _userPass;
  String _newPass;
  String _confirmPass;
  String _finalPass;
  //TabController controller;
  int _currentTab = 0;


  //search
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _policies;


  PageController _pageController;
  _validate() {
    if (_newPass != _confirmPass) {
      return 'do not match';
    }
  }

  _saved() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  /* @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }*/
/*
  _changePassword(){
    return showDialog(context: context,
    builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          
        ),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: MediaQuery.of(context).size.width * 0.1,
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('change pass'),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'current password'
                    ),

                    onSaved: (input) => _currentPass=input,
                    ),

                    
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      
                    decoration: InputDecoration(
                      labelText: 'new password'
                    ),
                    onSaved: (input) => _newPass=input,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'confirm password'
                    ),
                    onSaved: (input) => _confirmPass=input,
                    validator: (input)=>_validate(),

                    ),
                  ),

                  RaisedButton(onPressed:()=>_saved(), child: Text('save'),)
                ],
              ) ,
              ),
              )
        )
      );
    }

    );
    
    
  }*/

  _logoutPopup() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: 250.0,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Are you sure you want to logout?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF213458),
                          fontSize: 20.0,
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            width: 130.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 0.0),
                            child: RaisedButton(
                              child: Text('Logout',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                  )),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              onPressed: () => AuthService.logout(),
                              color: Color(0xFF213456),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            width: 150.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 0.0),
                            child: RaisedButton(
                              child: Text('Cancel',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                  )),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: Color(0xFF213456),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }
//SEARCH...

  _onClickPolicyName(String policy){
    Navigator.of(context).push(MaterialPageRoute(
      builder:(BuildContext context){
        return Scaffold(  
          appBar: AppBar(
            title: Text(
              policy,
              style: TextStyle(
              color: Color(0xFFD9E6F2),
            ),
            
            ),
             backgroundColor: Color(0xFF213458),
          ),
          body: PageView(
          controller: _pageController,
          children: <Widget>[
            PolicyDetailScreen(policyName: policy),
            NotificationScreen(),
          ],
          onPageChanged: (int index) {
            setState(() {
              _currentTab = index;
            });
          },
        ),
        bottomNavigationBar: CupertinoTabBar(
            activeColor: Color(0xFF82EEFD),
            inactiveColor: Color(0xFF9E9E9E),
            backgroundColor: Color(0xFF213458),
            currentIndex: _currentTab,
            onTap: (int index) {
              setState(() {
                _currentTab = index;
              });
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                Icons.rss_feed,
                size: 40.0,
              )),
              BottomNavigationBarItem(
                  icon: Icon(
                Icons.notifications,
                size: 40.0,
              ))
            ]),
        );
      } 
      )
      );
  }
_buildPolicyTile(Policy policy){
  return Container(
    color: Color(0xFFD9E6F2),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: Text(
              policy.name,
              style: TextStyle(
                color: Color(0xFF213458),
                fontSize: 17.0,
                
              ),
              ),
            onPressed: ()=>_onClickPolicyName(policy.name)
                ),
        ],
      ),
  );
  
}
  _clearSearch() {
    WidgetsBinding.instance.addPostFrameCallback((_)=>_searchController.clear());
   
    setState(() {
      _policies = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: Color(0xFFD9E6F2)),
          decoration: InputDecoration(
          
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Color(0xFFD9E6F2),
              fontSize: 17.0
            ),
            prefixIcon: Icon(Icons.search,color: Color(0xFFD9E6F2),),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear,),
              color: Color(0xFFD9E6F2),
              onPressed: ()=>_clearSearch(),
            )
            ),
            onSubmitted: (input){
              if(input.isNotEmpty){
              setState(() {
                _policies = DatabaseService.searchPolicy(input);
              });}
            },
        ),
        backgroundColor: Color(0xFF213458),
      ),
      body: _policies==null
      ?  PageView(
        controller: _pageController,
        children: <Widget>[
          Feed(),
          NotificationScreen(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      )
      
      
      
      : FutureBuilder(
        future: _policies,
        builder: (context,snapshot){
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Color(0xFFD9E6F2),
                          body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.data.documents.length==0) {
            return Scaffold(
              backgroundColor: Color(0xFFD9E6F2),
                          body: Center(
                
                child: Text('Sorry!The policy you are looking for is not found',
                style: TextStyle(
                  color: Color(0xFFD9E6F2),
                  fontSize: 20.0
                ),
                )
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index){
              Policy policy = Policy.fromDoc(snapshot.data.documents[index]);
              return _buildPolicyTile(policy);
            },);
        },),
        bottomNavigationBar: CupertinoTabBar(
          activeColor: Color(0xFF82EEFD),
          inactiveColor: Color(0xFF9E9E9E),
          backgroundColor: Color(0xFF213458),
          currentIndex: _currentTab,
          onTap: (int index) {
            setState(() {
              _currentTab = index;
            });
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
              Icons.rss_feed,
              size: 40.0,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.notifications,
              size: 40.0,
            ))
          ]) , 
      drawer: Drawer(
        child: Container(
          color: Color(0xFFD9E6F2),
          child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 40.0, bottom: 40.0)),
              ListTile(
                title: Container(
                    child: Row(
                  children: <Widget>[],
                )),
              ),
              ListTile(
                title: FlatButton(
                    padding: EdgeInsets.only(),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          size: 40.0,
                          color: Color(0xFF213458),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            'View Account',
                            style: TextStyle(
                                color: Color(0xFF213458), fontSize: 17.0),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(userId: Provider.of<UserData>(context).currentUserId)))),
              ),
              ListTile(
                title: FlatButton(
                  padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.history,
                        size: 40.0,
                        color: Color(0xFF213458),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Applied History',
                          style: TextStyle(
                              color: Color(0xFF213458), fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                  onPressed: null,
                ),
              ),
              ListTile(
                title: FlatButton(
                  padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.lock,
                        size: 40.0,
                        color: Color(0xFF213458),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                              color: Color(0xFF213458), fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                  onPressed: null,
                ),
              ),
              ListTile(
                title: FlatButton(
                  padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.exit_to_app,
                        size: 40.0,
                        color: Color(0xFF213458),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              color: Color(0xFF213458), fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                  //onPressed: ()=> Navigator.pushNamed(context, LoginScreen.id),
                  onPressed: _logoutPopup,
                ),
              ),
              ListTile(
                title: FlatButton(
                  padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.help,
                        size: 40.0,
                        color: Color(0xFF213458),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Government Helpline',
                          style: TextStyle(
                              color: Color(0xFF213458), fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                  onPressed: null,
                ),
              ),
              ListTile(
                title: FlatButton(
                  padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.question_answer,
                        size: 40.0,
                        color: Color(0xFF213458),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'FAQs',
                          style: TextStyle(
                              color: Color(0xFF213458), fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                  onPressed: null,
                ),
              ),
              ListTile(
                title: FlatButton(
                  padding: EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.info,
                        size: 40.0,
                        color: Color(0xFF213458),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'About Us',
                          style: TextStyle(
                              color: Color(0xFF213458), fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                  onPressed: null,
                ),
              ),
              ListTile(
                title: FlatButton(
                  padding: EdgeInsets.only(),
                  child: Row(children: <Widget>[
                    Icon(
                      Icons.perm_contact_calendar,
                      size: 40.0,
                      color: Color(0xFF213458),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Contact Us',
                        style:
                            TextStyle(color: Color(0xFF213458), fontSize: 17.0),
                      ),
                    ),
                  ]),
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
PageView(
        controller: _pageController,
        children: <Widget>[
          Feed(),
          NotificationScreen(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
          activeColor: Color(0xFF82EEFD),
          inactiveColor: Color(0xFF9E9E9E),
          backgroundColor: Color(0xFF213458),
          currentIndex: _currentTab,
          onTap: (int index) {
            setState(() {
              _currentTab = index;
            });
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
              Icons.rss_feed,
              size: 40.0,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.notifications,
              size: 40.0,
            ))
          ]),
 
 */
