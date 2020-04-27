import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapplication/screens/home.dart';
import 'package:myapplication/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email, _password;
  bool _isHidden = true;  //toggle password visibility
  


  _submit() {
    print(_email);
    print(_password);
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      AuthService.login(_email, _password);

      Navigator.pushNamed(context, Home.id);
    }
  }

  _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }


  openAlertBox() {
    String email;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          contentPadding: EdgeInsets.all(10.0),
          title: Text('Enter Registered Email Address'),
          content: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (input) => email = input,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if (email.isNotEmpty || email == null) {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                    msg: "Reset Link has been sent to $email",
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Color(0xffd9d9d9),
                  );
                  AuthService.sendPasswordResetEmail(email);
                }
              },
              child: Text(
                'Send',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFD9E6F2),
            ),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 130.0),
                child: Container(
                  // height: 20.0,
                  //width: 20.0,
                  child: Image(
                    height: 130.0,
                    width: 130.0,
                    image: AssetImage(
                      'assets/government-of-india.jpg',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 130.0, right: 30.0, top: 20.0, bottom: 0.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.input,
                        size: 40.0,
                        color: Color(0xFF213458),
                      ),
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF213458),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: TextStyle(
                                color: Color(0xFF213458),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF213458),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                            ),
                            validator: (input) {
                              input = input.trim();
                              if (input.contains('@')) {
                                return null;
                              } else {
                                return 'Please enter valid email id';
                              }
                            },
                            onSaved: (input) => _email = input,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Color(0xFF213458),
                                ),
                                focusColor: Color(0xFF213458),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF213458),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () => _toggleVisibility(),
                                  icon: _isHidden?Icon(
                                    Icons.visibility_off,
                                    color: Color(0xFF213458),
                                  ):Icon(
                                    Icons.visibility,
                                    color: Color(0xFF213458),
                                  ),
                                )),
                            validator: (input) => input.length < 6
                                ? 'Must be atleast 6 characters'
                                : null,
                            obscureText: _isHidden,
                            onSaved: (input) => _password = input,
                          ),
                        ),

                        
                      /* Padding(
                          padding: EdgeInsets.only(left: 200.0),
                          
                          child: FlatButton(
                            
                                child: Text(
                                  'Forgot Password?'
                              ),
                              onPressed: null,
                              ),
                        ),
*/

                        GestureDetector(
    onTap: openAlertBox,
    child: Text('Forgot Password'),
),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20.0),
                          child: Container(
                              height: 50.0,
                              width: 170.0,
                              child: RaisedButton(
                                child: Text('Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                onPressed: _submit,
                                color: Color(0xFF213456),
                              )),
                        ),


                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5.0),
                            child: Container(
                              height: 50.0,
                              width: 700.0,
                              child: FlatButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, SignUp.id),
                                child: Text(
                                  'Dont have an account? Sign up.',
                                  style: TextStyle(
                                    color: Color(0xFF213458),
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                            )
                            ),
                            
                      ],
                    ),
                  )
                ],
              )),
            ]),
          ),
        ),
      ),
    );
  }
}
