import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myapplication/screens/feed.dart';
import 'package:myapplication/screens/notificationscreen.dart';
import 'package:myapplication/screens/policydetailscreen.dart';

class PolicyNameScreen extends StatefulWidget {
  static final id = 'policynamescreen';
  String policyCategory;
  PolicyNameScreen({this.policyCategory});
  //String category = text;
  @override
  _PolicyNameScreenState createState() => _PolicyNameScreenState();
}

class _PolicyNameScreenState extends State<PolicyNameScreen> {

  String policyName;
  int _currentTab = 0;
  PageController _pageController;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9E6F2),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('policies')
              .where('Category', isEqualTo: widget.policyCategory)
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
                      padding: EdgeInsets.fromLTRB(8.0,4.0,8.0,0.0),
                      child: FlatButton(
                        child: Text(
                          document['Name'],
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Color(0xFF213458),
                            ),
                        ),
                        onPressed: () => _onClickPolicyName(document['Name']),
                      ),
                    ),
                  ],
                );
              },
            ).toList()
            );
          }
          ),
    );
  }
}
