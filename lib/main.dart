import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/screens/categoryinput.dart';

import 'package:myapplication/screens/feed.dart';
import 'package:myapplication/screens/home.dart';
import 'package:myapplication/screens/loginscreen.dart';
import 'package:myapplication/screens/otp.dart';
import 'package:myapplication/screens/policynamescreen.dart';
import 'package:myapplication/screens/profilescreen.dart';
import 'package:myapplication/screens/signup.dart';
import 'package:provider/provider.dart';

import 'models/userdata.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget _getScreenId(){
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return Home();
        }
        else{
          return LoginScreen();
        }
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
          child: MaterialApp(
       title: 'Login',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
            color: Color(0xFFD9E6F2),

            
          )

        ),
        home: _getScreenId(),
       routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUp.id: (context) =>SignUp(),
          OtpVerification.id: (context) => OtpVerification(),
          Home.id: (context) => Home(),
          CategoryInput.id: (context) => CategoryInput(),
          Feed.id: (context) => Feed(),
          ProfileScreen.id: (context) =>ProfileScreen(),
          PolicyNameScreen.id : (context) => PolicyNameScreen(),
        },
      ),
    );
  }
}

