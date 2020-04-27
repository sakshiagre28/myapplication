import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/screens/policynamescreen.dart';
import 'package:myapplication/services/database_service.dart';



import 'notificationscreen.dart';

class Feed extends StatefulWidget {
  static final String id = 'feed';
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int _currentTab = 0;
  PageController _pageController;


  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
  }

  String policyCategory;
  bool flag = false;
  var policyname;
  _onClickPolicyCategory(String category) {
    
    
    
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            category,
            style: TextStyle(
              color: Color(0xFFD9E6F2),
            ),
          ),
          backgroundColor: Color(0xFF213458),
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            PolicyNameScreen(policyCategory: category),
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
    }));
  }

  //searchbar
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _policies ;

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFFD9E6F2),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

               
                Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
                    child: FlatButton(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Agriculture',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF213458),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => _onClickPolicyCategory(
                            'Agriculture') //_onClickFlatButton('Agriculture')
                        )),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: FlatButton(
                    child: Row(children: <Widget>[
                      Text(
                        'Education',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF213458),
                        ),
                      )
                    ]),
                    onPressed: () => _onClickPolicyCategory('Education'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: FlatButton(
                    child: Row(children: <Widget>[
                      Text(
                        'Health',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF213458),
                        ),
                      )
                    ]),
                    onPressed: () => _onClickPolicyCategory('Health'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: FlatButton(
                    child: Row(children: <Widget>[
                      Text(
                        'Housing',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF213458),
                        ),
                      )
                    ]),
                    onPressed: () => _onClickPolicyCategory('Housing'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: FlatButton(
                    child: Row(children: <Widget>[
                      Text(
                        'Insurance',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF213458),
                        ),
                      )
                    ]),
                    onPressed: () => _onClickPolicyCategory('Insurance'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: FlatButton(
                    child: Row(children: <Widget>[
                      Text(
                        'Loan',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF213458),
                        ),
                      )
                    ]),
                    onPressed: () => _onClickPolicyCategory('Loan'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: FlatButton(
                    child: Row(children: <Widget>[
                      Text(
                        'Pension',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF213458),
                        ),
                      )
                    ]),
                    onPressed: () => _onClickPolicyCategory('Pension'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: FlatButton(
                    child: Row(children: <Widget>[
                      Text(
                        'Women and Children',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF213458),
                        ),
                      )
                    ]),
                    onPressed: () => _onClickPolicyCategory('Women and Children'),
                  ),
                ),
              ]),
        ),
      ),


    );
  }
}



